doc_2_pdf
==============

`doc_2_pdf` converts a folder structure containing `.doc`/`.docx` files into a folder structure of .pdf files


Requirements and Dependencies
-----------------------------

Developed/Tested with Ruby version 2.3, but it should work with any version >= 1.9.  `.doc`/`.docx` are converted to `.pdf` through the `libreconv` gem which depends on Libre Office.


Installation
-----------------------------

Add to your `Gemfile`:

```ruby
gem 'doc_2_pdf', '~> 1.0'
```


Usage
-----------------------------

First, configure `DocPdf`:

```ruby
DocPdf.configure(
  doc_dir: '/some/path/with/doc/files', # required
  pdf_dir: '/where/to/save/pdf/files'   # required
)
```

To generate all docs in `doc_dir`, execute `.convert!`:

```ruby
DocPdf.convert! do |pdf_path|
  puts "Created pdf file: #{pdf_path}"
end
```

`convert!` optionally accepts a code block with one argument.  This argument (`pdf_path` in the above example) will be a string representing the path of the newly created pdf relative to `pdf_dif` defined at configuration.  The folder structure `pdf_dir` will be identical to that of `doc_dir` but for every `.doc`/`.dox` file there will instead be a `.pdf` file with the same name.


Alternatively a single doc file can be converted to pdf using the `convert_single!` method:

```ruby
doc_dir = '/some/path/with/doc/files'
pdf_dir = '/where/to/save/pdf/files'

DocPdf.configure doc_dir: doc_dir, pdf_dir: pdf_dir

relative_pdf_path = DocPdf.convert_single! File.join(doc_dir, 'My Word Doc.doc')

puts File.join pdf_dir, relative_pdf_path
# => '/where/to/save/pdf/files/My Word Doc.doc/'
```


License
-----------------------------

MIT-LICENSE.
