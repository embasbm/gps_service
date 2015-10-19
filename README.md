REST service
Create a RESTful stand alone web application that is able to persist collections of GPS points (collection in JSON format). These collections are called traces. You can download sample traces from here.

Keep in mind that this web application should work for a large amount of users and that it is likely to receive about 10 times more read than write requests.

This is an example trace:

[{ "latitude": 32.9377784729004, "longitude": -117.230392456055 },
{ "latitude": 32.937801361084, "longitude": -117.230323791504 },
{ "latitude": 32.9378204345703, "longitude": -117.230278015137 },
{ "latitude": 32.9378204345703, "longitude": -117.230239868164 },
{ "latitude": 32.9378318786621, "longitude": -117.230209350586 },
{ "latitude": 32.9378814697266, "longitude": -117.230102539062 },
{ "latitude": 32.9378890991211, "longitude": -117.230072021484 },
{ "latitude": 32.9379081726074, "longitude": -117.230018615723 },
{ "latitude": 32.9379005432129, "longitude": -117.22998046875 },
{ "latitude": 32.937931060791, "longitude": -117.229949951172 },
{ "latitude": 32.9379615783691, "longitude": -117.229919433594 }]

Goals:

you can use any database you like
you should use the Ruby language for your implementation
you may use any framework or gem
implement all actions to perform CRUD on the restful resource "trace"
use the JSON format from above for the interface
the database design is up to you
Hints:

you can use a browser extension like postman or restclient
you can use the command line tool curl to do the requests

$ curl -i -X PUT -d @/tmp/trace1.json http://localhost:3003/traces/1

$ curl -i -X POST -d @/tmp/trace1.json http://localhost:3003/traces