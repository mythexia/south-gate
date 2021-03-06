class MapController < ApplicationController

  def index
    @issues_with_coords = Issue.all.where('latitude IS NOT NULL and longitude IS NOT NULL and status != 3 and status != 5')

    @json  = Gmaps4rails.build_markers(@issues_with_coords) do |issue, marker|
      marker_image_url = ''

      if issue.status == 0
        marker_image_url = '/images/markers/yellow.png'
      elsif issue.status == 1
        marker_image_url = '/images/markers/green.png'
      elsif issue.status == 2
        marker_image_url = '/images/markers/blue.png'
      elsif issue.status == 3
        marker_image_url = '/images/markers/red.png'
      elsif issue.status == 4
        marker_image_url = '/images/markers/purple.png'
      elsif issue.status == 5
        marker_image_url = '/images/markers/gray.png'
      end

      marker.lat issue.latitude
      marker.lng issue.longitude
      marker.infowindow render_to_string(:partial => "marker_window", :locals => {:issue => issue})
      marker.picture({
                         :url    => marker_image_url,
                         :width  => 32,
                         :height => 32
                     })
      marker.json({ :id => issue.id })
    end
  end

end