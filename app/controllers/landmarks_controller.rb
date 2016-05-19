class LandmarksController < ApplicationController

  set :views, Proc.new { File.join(root, "../views/landmarks") }

end
