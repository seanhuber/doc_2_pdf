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
      relative_pdf_path = convert_doc doc
      yield(relative_pdf_path) if block_given?
    end
  end

  def self.convert_single! doc
    convert_doc doc
  end

  def self.doc? file_path
    ['.doc', '.docx'].include? File.extname(file_path)
  end

  private

  def self.convert_doc doc
    raise ArgumentError, "Not a .doc/.docx file: #{doc}" unless doc?(doc)
    pdf_filename = File.basename(doc, '.*')+'.pdf'
    relative_path = File.dirname doc.gsub(@@doc_dir, '')
    relative_pdf_path = relative_path == '.' ? pdf_filename : File.join(relative_path, pdf_filename)
    pdf_path = File.join @@pdf_dir, relative_pdf_path
    FileUtils.mkdir_p File.dirname(pdf_path)
    Libreconv.convert doc, pdf_path
    relative_pdf_path
  end
end
