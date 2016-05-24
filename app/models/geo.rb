class Geo < ActiveRecord::Base
	require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'zip/zip'

	has_many :facilities
	has_attached_file :tracker
	validates_attachment_content_type :tracker, :content_type => %w(text/xml text/plain application/zip)

	before_save :parse_file

	  def parse_file
	    tempfile  = tracker.queued_for_write[:original]
	    if tempfile.content_type == 'application/zip'
	       zip = Zip::ZipFile.open("#{tempfile.path}")         # open zip
           entry = zip.entries.reject(&:directory?).first      # take first non-directory
           xml_source = entry.get_input_stream{|is| is.read }  # read file contents
	       doc       = Nokogiri::XML(xml_source)
	     elsif tempfile.content_type == 'text/xml'
	     	doc = Nokogiri::XML(tempfile)
	     end
	     	
	    parse_xml(doc)
	  end

	  def parse_xml(doc)
	    doc.root.elements.each do |node|
	      parse_facilities(node)
	    end
	  end

	  def parse_facilities(node)
	    if node.node_name.eql? 'FacilitySite'
	      tmp_facility = Facility.new
	      node.elements.each do |node|
	        tmp_facility.site_name         = node.text.to_s if node.name.eql? 'FacilitySiteName'
	        tmp_facility.address           = node.text.to_s if node.name.eql? 'LocationAddressText'
	        tmp_facility.locality_name     = node.text.to_s if node.name.eql? 'LocalityName'
	        tmp_facility.state_code        = node.text.to_s if node.name.eql? 'LocationAddressStateCode'
	        tmp_facility.zip_code          = node.text.to_s if node.name.eql? 'LocationZIPCode'
	        tmp_facility.latitude          = node.text.to_s if node.name.eql? 'LatitudeMeasure'
	        tmp_facility.longitude         = node.text.to_s if node.name.eql? 'LongitudeMeasure'
	      end
	      self.facilities << tmp_facility
	    end
	  end
end
