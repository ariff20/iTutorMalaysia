Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});
Parse.Cloud.define('editUser', function(request, response) {
                   var userId = request.params.userId,
                   rating = request.params.rating;
                   
                   var User = Parse.Object.extend('_User'),
                   user = new User({ objectId: userId });
                   
                   user.set('Rating', rating);
                   
                   Parse.Cloud.useMasterKey();
                   user.save().then(function(user) {
                                    response.success(user);
                                    }, function(error) {
                                    response.error(error)
                                    });
                   });
Parse.Cloud.define('totalUser', function(request, response) {
                   var userId = request.params.userId,
                    numberofrating = request.params.numberofrating,
                    totalrating = request.params.totalrating;
                   
                   var User = Parse.Object.extend('_User'),
                   user = new User({ objectId: userId });
                   
                   user.set('TotalRatings', totalrating);
                   user.set('NumberofRatings',numberofrating)
                   
                   Parse.Cloud.useMasterKey();
                   user.save().then(function(user) {
                                    response.success(user);
                                    }, function(error) {
                                    response.error(error)
                                    });
                   });
                   
                   

