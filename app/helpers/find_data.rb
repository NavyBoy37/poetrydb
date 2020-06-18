require 'sinatra'

class Web < Sinatra::Base

  def find_data(search_hash, output_fields = { '_id' => 0, 'title' => 1, 'author' => 1, 'lines' => 1, 'linecount' => 1 })
    # limit returned documents if 'poemcount' key available
    if search_hash.keys.include?('poemcount')
      poemcount = search_hash['poemcount']
      search_hash.delete('poemcount')

      @findings_data = settings.poetry_coll.find(
        search_hash, { :projection => output_fields }
      ).limit( poemcount ).to_a
    # otherwise return all documents
    else
      @findings_data = settings.poetry_coll.find(
        search_hash, { :projection => output_fields }
      ).to_a
    end

    @findings_data
  end

end
