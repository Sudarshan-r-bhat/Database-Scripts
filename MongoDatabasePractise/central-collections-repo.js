// This file will contain all collection creation and deletion that will ever be done from 17th August 2021.
/*
	BASIC COMMANDS THAT I NEED TO KNOW:
	refer:
		https://docs.mongodb.com/mongodb-shell/write-scripts/#std-label-mdb-shell-write-scripts
		ls()
		pws()
		cd('path')
		load(filename.js); // to load and execute  a JS file in mongodb.
		mkdir(path);
		
	TO RUN FUNCTIONS WITH ARGUMENTS IN MONGO DB:	
		db.runCommand({
			eval: function(arg1, arg2){
				print(arg1, arg2);
			},
			args: ['one', 'two']
		})
		NOTE: THIS DOESN'T WORK WITH SHARDED DB.
		
	TO CONNECT TO MONGODB FROM NODEJS:
	
		dbName = 'testdb';
		conn = new Mongo('mongod://localhost:27017');
		db = conn.getDB(dbName);

	RUNNING THIS SCRIPT FROM MONGOSHELL:
		$ load('central-collections-repo.js');
	RUNNING THIS SCRIPT FROM HOST CMD:
		$ mongo --eval "load('central-collections-repo.js')"
*/

const prefix='[ log ]';
print('***************************************************************************');
print('************************* CENTRAL-COLLECTIONS-REPO ************************');
print('***************************************************************************');
print(prefix, "RUNNING ALL SCRIPTS", '.............');

db = db.getSiblingDB('testdb');

print(prefix, 'selected db = ', db.getName());
print(prefix, 'list of all available collections = ', db.getCollectionNames())
print();

print(prefix, 'drop and insert movies collection');

db.movies.drop();

db.movies.insertOne({
	title: 'shreshah',
	ratings: 9, 
	generes: ['action'],
	releaseYear: 2021
});

db.movies.insertMany([
{
	title: 'coda',
	ratings: 8.1,
	generes: ['drama', 'comedy'],
	releaseYear: 2021
	
},
{
	title: 'black widow',
	ratings: 6.8,
	generes: ['action', 'drama', 'comedy', 'adventure'],
	releaseYear: 2021,
	actors: { "scarlett johansson": {age: 32, origin: "english"}}
},
{
	title: 'thor',
	ratings: 7.1,
	generes: ['action', 'drama', 'comedy', 'adventure'],
	releaseYear: 2011
},
{
	title: 'captain marvel',
	ratings: 7.8,
	generes: ['action', 'drama', 'comedy', 'adventure'],
	releaseYear: 2019
},
{
	title: 'iron man 2',
	ratings: 8.4,
	generes: ['action', 'drama', 'comedy', 'adventure'],
	releaseYear: 2010
},
{
	title: 'bahubali',
	ratings: 8.0,
	generes: ['action', 'drama', 'comedy', 'adventure'],
	releaseYear: 2017
}
]);



db.movies.insertOne({
	title: "giant slayer",
	ratings: 7.3,
	generes: ['action', 'drama', 'comedy', 'adventure'],
	releaseYear: 2019,
	actors: {nicholas: {age: 36, origin: "english"}, eleanor: {age: 34, origin: "english"}}
});



db.testCollection.drop();

db.testCollection.insertMany(
[
	{
			"_id" : ObjectId("611d264c8ba302f129ee5d8a"),
			"sum" : 0,
			"avg" : 0,
			"numbers" : [
					1,
					2,
					3
			],
			"lastModified" : ISODate("2021-08-19T06:31:43.090Z"),
			"size" : "less than 3",
			"mapped" : [
					101,
					102,
					103
			]
	},
	{
			"_id" : ObjectId("611f7f0781e443a4b46db309"),
			"numbers" : [
					45,
					343,
					32,
					112
			]
	}

]

);






print('*************** SCRIPT EXECUTED SUCCESSFULLY **************************');
