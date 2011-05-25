module Find
  class Parser
    def initialize args
      @args = args
      @params = {}
      parse
    end

    def to_params
      @params
    end

    protected

    def parse
      @args.each_with_index do |arg, i|
        case arg
          when "--help", "-h"
            @params[:help] = true
          when "--name", "-n"
            @params[:name] = @args[i+1]
          when "--type", "-t"
            @params[:type] = @args[i+1]
          when "--user", "-u"
            @params[:owner] = @args[i+1]
          when "--maxdepth", "-md"
            @params[:max_depth] = @args[i+1]
          when "--dir", "-d"
            @params[:dir] = @args[i+1]
          else
            @params[:dir] = arg if i == 0
        end
      end
    end
  end
end
