class PostLoadService < ApplicationService
  def initialize(archive_params)
    @archive = archive_params.tempfile
  end

  def call
    Zip::File.open(@archive.path) do |zip_file|
      zip_file.each do |entry|

        Post.import  posts_from(entry), ignore_errors: true
      end
    end
  end

  private
  def posts_from(entry)
    sheet = RubyXL::Parser.parse_buffer(entry.get_input_stream.read)[0]
    sheet.map do |row|
      cells = row.cells
      Post.new( title: cells[2].value,
               description: cells[3].value,
                user_id: cells[0].value,
                post_category_id: cells[1].value)
    end
  end
end
