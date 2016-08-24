class DocPdf
  def self.configure **opts
    [:doc_dir, :pdf_dir].each do |required_opt|
      raise ArgumentError, "Missing required config option: :#{required_opt}" unless opts[required_opt]
    end
    @@doc_dir = File.join(opts[:doc_dir], '') # adds trailing '/' if it doesn't already have one
    @@pdf_dir = File.join(opts[:pdf_dir], '') # adds trailing '/' if it doesn't already have one
  end

  def self.convert!
    Dir.glob(File.join(@@doc_dir, '**', '*.{doc,docx}')) do |doc|
      pdf_filename = File.basename(doc, '.*')+'.pdf'
      relative_path = File.dirname doc.gsub(@@doc_dir, '')
      relative_pdf_path = relative_path == '.' ? pdf_filename : File.join(relative_path, pdf_filename)
      pdf_path = File.join @@pdf_dir, relative_pdf_path
      FileUtils.mkdir_p File.dirname(pdf_path)
      Libreconv.convert doc, pdf_path
      yield(relative_pdf_path) if block_given?
    end
  end
end
