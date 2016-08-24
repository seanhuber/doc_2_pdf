require 'spec_helper'

describe DocPdf do
  it 'is configurable' do
    expect {
      DocPdf.configure
    }.to raise_error 'Missing required config option: :doc_dir'

    expect {
      DocPdf.configure(
        doc_dir: '/some/path/of/docs'
      )
    }.to raise_error 'Missing required config option: :pdf_dir'

    expect {
      DocPdf.configure(
        doc_dir: '/some/path/of/docs',
        pdf_dir: '/some/path/of/pdfs'
      )
    }.not_to raise_error
  end

  it 'can convert a directory of doc files' do
    pdf_dir = File.expand_path('../pdfs', __FILE__)
    DocPdf.configure(
      doc_dir: File.expand_path('../docs', __FILE__),
      pdf_dir: pdf_dir
    )

    expected_pdfs = [
      'OldFile.pdf',
      'Test.pdf'
    ]

    idx = 0
    DocPdf.convert! do |pdf|
      expect(pdf).to eq(expected_pdfs[idx])
      expect(File).to exist(File.join(pdf_dir, pdf))
      idx += 1
    end

    FileUtils.rm_rf pdf_dir
  end
end
