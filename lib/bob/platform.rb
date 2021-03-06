require 'haml'

class Bob::Platform
  attr :name

  def initialize(name, config)
    @name = name
    @config = {
      "build_folder" => "data",
      "platform_folder_name" => @name,
      "assets" => ["images"],
      "sass_file" => "main"
    }.merge(config)
  end

  def platform_folder
    File.join("platforms", @config["platform_folder_name"])
  end

  def output_folder(subfolder = "")
    File.join(platform_folder, @config["build_folder"], subfolder)
  end

  def input_sass_file
    @config["sass_file"]
  end

  def output_sass_file
    output_folder("main.css")
  end

  def output_html_file
    output_folder("index.html")
  end

  def assets
    @config["assets"]
  end

  # Stuff used in the templates
  # NONE OF THIS SHOULD BE HERE, ZOMG HAMPTON, WHAT ARE YOU DOING!?!?!
  def bundle_javascripts(*files)
    (files.map do |file|
      File.read(File.join("src/javascripts", file + ".js"))
    end).join("\n")
  end

  def render(file = "index.haml")
    engine = Haml::Engine.new(File.read(File.join("src", file)))
    engine.render(self)
  end
end