Project Haystack Adapter
---

*Need a better name!*

### Projects
- Load a project using name specified in config file: 


```
ProjectHaystack::Config.projects['project_name']
```



- Call `read` method to search for points:


```
project.read({:filter => '"yearBuilt > 2000"'}) 
```


```
project.read({:id => "@my_rec_id"})
```

### Points
- Define a point class in your application that requires instance variables `haystack_project_name` and `haystack_point_id`.
- Include point functionality: 

```
include ProjectHaystack::Point
```

- Call `data` method to load data for point.

```
point.data('yesterday')
```
