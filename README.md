HaystackRuby
---

The open source [Project Haystack](http://project-haystack.org/) initiative defines meta data and communication standards related to data from buildings and intelligent devices. The [Project Haystack REST API](http://project-haystack.org/doc/Rest) defines standard formats and operations for exchanging Haystack tagged data over HTTP.  The HaystackRuby gem wraps calls to this REST API to enable Ruby application to easily integrate data hosted on a Project Haystack compliant server.

The HaystackRuby gem was developed at the [National Renewable Energy Lab](http://www.nrel.gov/) to support applications related to campus energy.  We hope that this tool may be useful to others.  If you have ideas or are interested in contributing to the codebase, please contact us. 

## Requirements
HaystackRuby has been tested with Ruby 2.4.0.

## Installation
#### Rails
Add `haystack_ruby` to your Gemfile and create a `config/haystack_ruby.yml` file with your [environment and project settings](#settings-file).

#### Without Rails
Install `haystack_ruby`.  You will need to create a [settings file](#settings-file) and call `HaystackRuby::Config.load!(my_config_file)` to initialize projects.  

#### Settings File 
Hopefully this goes without saying, but***the settings file contains credentials critical to the security of your data and should be kept private.***

The YAML settings file is organized first by environment, then by project.  See the [example.yml](config/example.yml).  Each project must include one of 
1. `credentials` - The Base64 encoding of the string `<username>:<password>`.  If this is present, HaystackRuby will attempt to  use Basic Authentication for authorization.  Basic Authentication is not part of the Project Haystack standard but may be supported in some implementations.
2. `username` and `password` - If present, HaystackRuby will attempt to use [SCRAM Authentication](http://project-haystack.org/doc/Auth#scram), a multi-message protocol, to agree on a auth token with the server.  SCRAM  is the Authentication standard defined by Project Haystack.

##Usage

#### Projects
- Load a project using name specified in config file: 


```
my_project = HaystackRuby::Config.projects['project_name']
```



- Call `read` method to search for points:


```
project.read({:filter => '"yearBuilt > 2000"'}) 
```


```
project.read({:id => "@my_rec_id"})
```

#### Points
HaystackRuby::Point functionality can be included on any object that responds to the following instance methods: `self.haystack_project_name`, `self.haystack_point_id`, `self.haystack_time_zone`. 

Your class might looks something like:

```
class MyPoint
    include HaystackRuby::Point
    def initialize(project, id, tz)
        @haystack_project_name = project
        @haystack_point_id = id
        @haystack_time_zone = tz
        ...
    end
    ...
end
```

You might also choose to persist instances of your point class using an ORM framework like ActiveRecord.  In this case, the required methods would correspond to database fields.

You will now be able to call methods defined in the HaystackRuby::Point module on your instance of MyPoint.  These include:

* `data(start, finish = nil, as_datetime = false) ` 

Load data for point. This calls the `his_read` method under the hood. `start` param is required and can be String, DateTime or Date. `start` and `finish` are used together to construct the range Str as described in [Haystack docs](http://project-haystack.org/doc/Ops#hisRead). `as_datetime` determines whether timestamps will be returned as integers or DateTime objects. 

Examples:
```
#all data since yesterday (start of day)
point.data('yesterday') 
#all data from yesterday (beginning of day through beginning of today)
point.data(Date.today, Date.today.prev_day) 
```
* `write_data(data)`

Accepts array of {time: xx, value: xx} hashes, handles conversions for Haystack timestamp formating, and wraps call to [hisWrite op](http://project-haystack.org/doc/Ops#hisWrite).  Timestamps can be passed in as Integers, Dates, or DateTimes.

* `meta_data`

Makes a [read](http://project-haystack.org/doc/Ops#read) request by id to the API and returns metadata for the single point. 

## Testing
HaystackRuby uses [RSpec](http://rspec.info/) for testing.  To configure your app for testing, update the [example.yml](config/example.yml) file with real project details for the test environment.  Update the configuration constants at the top of the [spec_helper.rb](spec/spec_helper.rb) file per comments there.  *Note that the supplied point id you provide will be written to by tests and should not be used outside testing.*

To run the full suite of tests, `cd` to the root directory of gem code and run

``
rspec spec/
``
