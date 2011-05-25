require 'etc'

module Find
  class Finder
    
    FILE_TYPES = ['f', 'd', 'l', 's']
    
    def initialize(dir, params = {})
      if dir.is_a? Hash
        params = dir
      elsif dir.is_a? String
        params[:dir] = dir
      end
      @result = []
      show_help if params[:help]
      if !params[:type].nil? and !FILE_TYPES.include?(params[:type])
        @result.unshift "Wrong file type"
        show_help
      else
        @type = params[:type]
      end
      @start_dir    = params[:dir] || './'
      @name         = params[:name]
      @name         = Regexp.new(@name) if @name
      @owner        = params[:owner]
      @max_depth    = params[:max_depth]
      @max_depth    = @max_depth.to_i if @max_depth
      @current_dir  = @start_dir
    end

    def find current_dir = nil, depth = 0
      return if show_help?
      current_dir ||= @start_dir
      begin
        Dir.foreach(current_dir).each do |name|
          path = File.join(current_dir, name)
          @result.push(path) if name?(name) and type?(path) and owner?(path) and !point_name?(name)
          if File.directory?(path) and !point_name?(name) and !File.lstat(path).symlink?
            find(path, depth + 1) if depth?(depth + 1)
          end
        end
      rescue Errno::EACCES
        @result.push("#{current_dir} - Permission denied")
      rescue Errno::ENOTDIR
        @result.push("#{current_dir} - Bad file descriptor")
      rescue Errno::ENOENT
        @result.push("#{current_dir} - No such file or directory")
      end
      @result
    end

    def to_s
      @result.join("\n")
    end

    protected

    def show_help
      return if show_help?
      @help = true
      @result.push "How to use find"
      @result.push "find [DIRECTORY] [OPTS]"
      @result.push "--help -h       show this help"
      @result.push "--name -n       find by regex name '--name .*\.js$'"
      @result.push "--type -t       find by file type, f - file, d - directory, l - symlink, s - socket '--type f'"
      @result.push "--user -u       find by file user owner '--user root'"
      @result.push "--maxdepth -md  immersion in a directory '--maxdepth 3'"
    end

    def show_help?
      !!@help
    end

    def name? name
      @name.nil? or @name =~ name
    end

    def type? path
      @type.nil? or
      (@type == 'l' and File.symlink?(path)) or
      (@type == 'f' and File.file?(path)) or
      (@type == 'd' and File.directory?(path)) or
      (@type == 's' and File.socket?(path))
    end

    def owner? path
      @owner.nil? or Etc.getpwuid(File.lstat(path).uid).name == @owner
    end

    def depth?(depth)
      @max_depth.nil? or depth <= @max_depth
    end

    def point_name? name
      name == '.' or name == '..'
    end

  end
end
