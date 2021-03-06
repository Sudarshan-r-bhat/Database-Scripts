// This file will contain all the QUERY OPERATIONS that will ever be done from 17th August 2021.
/*
	TO EXECUTE THIS FILE FROM CMD:
		$ cd C:\Users\sudar\space-1\GitLabPersonal\databases\MongoDatabasePractise
		$ mongo --eval "load(ls()[1].slice(2))"
		
	TO OUTPUT THE RESULT OF QUERY:
		. convert the result to array and store it in a variable.
		. use printjson() function to log the result.
	TO RUN SCRIPT FROM WITHIN THE MONGOSHELL:
		$ load(ls()[1].slice(2));
		
	note: the way you query the embeded object and array are the same.
	
		
		
*/

const prefix='[ log ]';
var result = [];

print('***************************************************************************');
print('************************* CENTRAL-QUERY-REPO-1 ************************');
print('***************************************************************************');
print(prefix, "RUNNING ALL QUERIES ", '.............');

db = db.getSiblingDB('testdb');

print(prefix, 'selected db = ', db.getName());
print(prefix, 'list of all available collections = ', db.getCollectionNames())
print();

// ============================ 17 AUGUST 2021

// usage of $in 
query = db.movies.find({title: {$in : ['black widow', 'iron man 2']}});
result = db.movies.find({title: {$in : ['black widow', 'iron man 2']}}).toArray();
print(prefix, query);
printjson(result);



// usage of $or, $and, $gte, $gt, $lt, $lte

query = db.movies.find({
	ratings: {$gte: 6.8},
	$and: [{releaseYear: {$gte: 2020}}]
})
result = db.movies.find({
	ratings: {$gte: 6.8},
	$and: [{releaseYear: {$gte: 2020}}]
}).toArray();

print(prefix, query);
printjson(result);




// Update query 
print(prefix, 'update statements to modify actors type');
query = db.movies.updateOne({title: 'giant slayer'}, { $set: {actors: [
	{
		"name": "nicholas",
		"age" : 36,
		"origin" : "english"
	},
	{
		"name": "eleanor",
		"age" : 34,
		"origin" : "english"
	} 
	]
}});
print(prefix, query);
print(prefix, 'updated the actors type');


// query on the nested field/document, $all, $elemMatch, $size, query for array index position
print(prefix, 'printing all movies with actors of age 34 and 36');
query =  
	db.movies.find({ "actors.age": {$all : [34, 36]} });
result = 
	db.movies.find({ "actors.age": {$all : [34, 36]} }).toArray();
print(prefix, query);
printjson(result);


print(prefix, 'printing all movies consisting actors of age > 30 named nicholas using $elemMatch ');
query=db.movies.find({ "actors": {$elemMatch: {"name": "nicholas",  "age": {$gte: 30}}}});
result=db.movies.find({ "actors": {$elemMatch: {"name": "nicholas",  "age": {$gte: 30}}}}).toArray();
print(prefix, query);
printjson(result);



// ============================ 18 AUGUST 2021

// QUERY TO RETURN SPECIFIC PART/FIELDS OF THE MATCHED OBJECTS.
print(prefix, 'QUERY TO RETURN SPECIFIC PART/FIELDS OF THE MATCHED OBJECTS.');
query =  
	db.movies.find({ "actors.age": {$all : [34, 36]} }, {actors: 1});
result = 
	db.movies.find({ "actors.age": {$all : [34, 36]} }, {actors: 1}).toArray();
print(prefix, query);
printjson(result); 



// QUERY TO CHECK THE FIELD TO BE null , IF KEYS EXISTS
print(prefix, 'QUERY TO CHECK THE FIELD TO BE null , IF OR KEYS EXISTS');
query = 
	db.movies.find({actors: {$exists: false}});
result = 
	db.movies.find({actors: {$exists: false}}).toArray();
print(prefix, query);
printjson(result);


query = 
	db.movies.find({actors: {$type: 10}});
result = 
	db.movies.find({actors: {$type: 10}}).toArray();
print(prefix, query);
printjson(result);





// TO GET THE CURSOR ON THE ARRAY.
// type: 1, 2, 3, 4, 5, 6, .... == double, string, object, arrary, binData, undefined, objectId, bool, date, 10 = null, 

query = 
	db.movies.find({actors: {$exists: true, $type: 3}});
var myCursor = 
	db.movies.find({actors: {$exists: true, $type: 3}});
print(prefix, query);
while(myCursor.hasNext()) {
	print( tojson(myCursor.next()) );
}
// myCursor.forEach(x => print( tojson(x) ) );

// 
print(prefix, 'UPDATE QUERY TO ADD A NEW FIELD \'LAST-MODIFIED-DATE\' ');
query = 
	db.movies.updateMany({}, {$currentDate: {lastModified: true}});
result = 
	db.movies.updateMany({}, {$currentDate: {lastModified: true}});
print(prefix, query);
printjson(result);



		
		
		


/*
*/


print('*************** SCRIPT EXECUTED SUCCESSFULLY **************************');
