module ApplicationHelper

  def auth_token
    <<-HTML.html_safe
      <input
        type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML
  end
  
  def featured_photo(rental)
    if rental.photos.first
	    source = rental.photos.first.file.url(:big)
		else
			source = asset_path 'rental_default.jpeg'
    end
    
    "<img class=\"rental-photo\" src=\"#{source}\" alt=\"apartment rental photo\">".html_safe
  end

end
