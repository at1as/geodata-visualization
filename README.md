# Geodata Visualization

WebGL Globe that fetches geodata and displays it in real time.

Repeated geography entries will tally as shown in the distributions below


### Screenshots

<img src="http://at1as.github.io/github_repo_assets/realtime-geography-metrics.png">


### Publishing Data

Currently retrieves data from redis. Geodata should be stored in redis under "coordinates" in the format "#{latitude},#{longitude}".

This is intended for use with a system that will publish data to redis in real time, or for use against 


```
  # Examples

  $ rpop "coordinates"
    => "35.685,139.7513889"

  $ rpop "coordinates"
    => "43.666667,-79.42"
  
  $ rpop "coordinates"
    => "43,-79"
```

The precision of the latitude and longitude does not matter, but it must be comma separated.


### Running

Relies on a redis instance (connects on defaults ports. Modify this is in `run.rb`)

JavaScript libraries are fetched from CDNs, so the only dependencies necessary to install are the ruby dependencies listed in `run.rb`.

```
$ RECENTER=TRUE INTERVAL=1000 ruby run.rb
```

Environment Variables:
* `RECENTER` (whether the globe should recenter around the latest incoming coordinate. Default is false)
* `INTERVAL` (how often to poll redis for data in ms. Default is 500 ms)


### Dependencies

Much of the globe.js comes from here https://github.com/askmike/realtime-webgl-globe/

