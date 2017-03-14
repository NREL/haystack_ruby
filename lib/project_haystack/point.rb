require 'date'
# require 'active_support'
module ProjectHaystack
  module Point
    
    # is this Point valid for purposees of Project Haystack Integration?  
    def haystack_valid?
      return self.haystack_project_name.present? && self.haystack_point_id.present? && self.haystack_time_zone.present?
    end

    def haystack_project
      @project ||= ProjectHaystack::Config.projects[self.haystack_project_name]
    end

    def connection
      haystack_project.connection
    end

    def his_read(range)
      query = ["ver:\"#{haystack_project.haystack_version}\"",'id,range',"@#{self.haystack_point_id},\"#{range}\""]
      pp query.join "\n"
      res = connection.post('hisRead') do |req|
        req.headers['Content-Type'] = 'text/plain'
        req.body = query.join("\n")
      end
      JSON.parse! res.body
    end

    def meta_data
      # TODO set / refresh haystack_time_zone from the tx in returned data
      # read request on project to load current info, including tags and timezone
      res = haystack_project.read({:id => "@#{self.haystack_point_id}"})['rows'][0]
    end

    # data is ascending array of hashes with format: {time: epochtime, value: myvalue}
    def his_write(data)
      query = 
        ["ver:\"#{haystack_project.haystack_version}\" id:@#{self.haystack_point_id}",'ts,val'] + data.map{ |d| "#{d[:time]},#{d[:value]}"}

      res = connection.post('hisWrite') do |req|
        req.headers['Content-Type'] = 'text/plain'
        req.body = query.join("\n")
      end

      JSON.parse(res.body)['meta']['ok'].present?
    end

    def data(start, finish = nil, as_datetime = false) # as_datetime currently ignored
      return unless haystack_valid? #may choose to throw exception instead

      range = [start]
      range << finish unless finish.nil?
      # clean up the range argument before passing through to hisRead
      # ----------------
      r = ProjectHaystack::Range.new(range, self.haystack_time_zone)
  
      res = his_read r.to_s
      reformat_timeseries(res['rows'], as_datetime)
    end

    def write_data(data)
      # format data for his_write
      data = data.map do |d| 
        { 
          time: ProjectHaystack::Timestamp.convert_to_string(d[:time], self.haystack_time_zone), 
          value: d[:value]
        }
      end
      his_write data
    end

    # map from 
    def reformat_timeseries data, as_datetime
      data.map do |d|
        time = (as_datetime) ? DateTime.parse(d['ts']) : DateTime.parse(d['ts']).to_i
        val = ProjectHaystack::Object.new(d['val'])
        {:time => time, :value => val.value}
      end
    end
  end
end