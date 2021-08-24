// This file will contain all the QUERY OPERATIONS that will ever be done from 17th August 2021.
/*
	TO EXECUTE THIS FILE FROM CMD:
		$ C:\Users\sudar\space-1\GitLabPersonal\databases\MongoDatabasePractise
		$ mongo --eval "load(ls()[2].slice(2))"
		
	TO OUTPUT THE RESULT OF QUERY:
		. convert the result to array and store it in a variable.
		. use printjson() function to log the result.
	TO RUN SCRIPT FROM WITHIN THE MONGOSHELL:
		
		$ cd('C:/Users/sudar/space-1/GitLabPersonal/databases/MongoDatabasePractise/')
		$ load(ls()[2].slice(2));
		
	note: the way you query the embeded object and array are the same.
	
		
		
*/

const prefix='\r\n[ log ]';
var result = [];
var query = '';

print('***************************************************************************');
print('************************* CENTRAL-QUERY-REPO-2 ************************');
print('***************************************************************************');
print(prefix, "RUNNING ALL QUERIES ", '.............');

db = db.getSiblingDB('testdb');

print(prefix, 'selected db = ', db.getName());
print(prefix, 'list of all available collections = ', db.getCollectionNames())
print();

// ============================ 18 AUGUST 2021
// AGGREGATION METHODS.


result = 
	db.testCollection.aggregate([
			{$unwind: "$numbers"},
			{
				$group: {
					_id: "$_id",
					avg: {$avg: "$numbers"}
				} 
		}	
	]).toArray();
	
printjson(result);



// ============================ 19 AUGUST 2021
// UPDATE QUERY TO STANDARDIZE THE FIELDS FOR THE DOCUMENT.


print(prefix, 'UPDATE QUERY TO STANDARDIZE THE FIELDS FOR THE DOCUMENT');
query = 
	db.testCollection.updateMany({}, [
		{$replaceRoot: { newRoot:
			{ $mergeObjects: [{
					sum: 0,
					avg: 0,
					numbers: []
			}, "$$ROOT"]
			}
		} },
		{$set: {lastModified: "$$NOW"}}
	]);

// print(prefix, tojson(query));


// SWITCH STATEMENT IN UPDATE QUERY
print(prefix, 'SWITCH STATEMENT IN UPDATE QUERY');

result = 
db.testCollection.aggregate(
		[ {
			
			$project: {
				size: { $switch: { 
				branches: [
				{case: {$gte: [{$size: "$numbers"}, 10]}, then: "more than 10" }, 
				{case: {$gte: [{$size: "$numbers"}, 6]}, then: "more than six"},
				{case: {$gte: [{$size: "$numbers"}, 3]}, then: "more than equal to 3"}
			], 
				default: "less than 3"
			}},
			size2: {$size: "$numbers"}}
			}
		]).toArray();
// print(prefix, tojson(query));
printjson(result);
		
		
// CONCAT ARRAYS IN PROJECTION
db.testCollection.aggregate([
{
	$project: {
		newArray: {
			$concatArrays: ["$numbers", [10, 32, 22]]
		}
	}
}
]);


// QUERY TO COMPARE THE SIZE OF AN ARRAY.
result =
	db.testCollection.aggregate([
	{
		$project: {
			status: {
				$gte : [  {$size: "$numbers"}, 3  ]
			}
		}
	}
	]).toArray();
// print(prefix, query);
print(result);


// QUERY TO TRANSFORM THE DOCUMENT. USING $addFields, $map : input: as: in
result =
	db.testCollection.updateMany({}, [
		{
			$addFields: {
				"mapped": {
					$map: {
						input: "$numbers",
						as: "numbers",
						in: { $add: ["$$numbers", 100] }
					}
				}
			}
		}
	]);
// print(prefix, query);
print(prefix, tojson(result));



// ================ 20 AUG 2021

// QUERY TO FETCH THE STATES WITH POPULATION > 10 MILLION FROM 'zips' collection
// first stage groups the state by aggregating the documents, second stage filters based 
// on the population.
result = 
	db.zips.aggregate(
	[
	{ 
		$group: {
			_id: "$state", 
			totalPopulation: { $sum: "$pop" } 
		}
	},
	{
		$match: {
			totalPopulation: { $gte: 10*1000*1000}
		}
	}
	]
	).toArray();
// print(prefix, query);
print(prefix, tojson(result));



print(prefix, 'QUERY TO CALCULATE THE AVG CITY POPULATION OF EACH STATE.');
result = 
db.zips.aggregate(
[
	{
		$group: {
			_id: { state: "$state", city: "$city"},
			pop: { $sum: "$pop" } 
		}
	},
	{
		$sort: { "_id.state": 1}
	},
	{
		$group: {
			_id: "$_id.state",
			averageCityPopulation: {$avg: "$pop"}
		}
	}
]
).toArray();
// print(prefix, query);
print(prefix, tojson(result));




// QUERY TO CALCULATE THE AVG CITY POPULATION OF all the STATE.
print(prefix, 'QUERY TO CALCULATE THE AVG CITY POPULATION OF all the STATE');
result = 
db.zips.aggregate(
[
	{
		$group: {
			_id: { state: "$state", city: "$city"},
			pop: { $sum: "$pop" } 
		}
	},
	{
		$sort: { "_id.state": 1}
	},
	{
		$group: {
			_id: "All states",
			averageCityPopulation: {$avg: "$pop"}
		}
	}
]
).toArray();
// print(prefix, query);
print(prefix, tojson(result));



// $merge stage in aggregation pipeline.

// TODO:



// MAP-REDUCE TO AGGREGATION PIPELINE.
// QUERY TO GET THE LIST OF ALL MOVIE TITLES.
print(prefix, ' QUERY TO GET THE LIST OF ALL MOVIE TITLES.');
result = 
db.movies.aggregate(
[
	{
		$project: {
			_id: "$_id",
			title: "$title"
		}
	},
	{
		$group: {
			_id: 0,
			allTitles: {
				$accumulator: {
					init: function() {
						return '';
					},
					initArgs: [],
					accumulate: function(state, value) {
						return value + ', ' + state;
					},
					accumulateArgs: ["$title"],
					merge: function(state1, state2) {
						return state1 + state2;
					},
					lang: "js"
				}
			}
		}
	}
]
).toArray();
// print(prefix, query);
print(prefix, tojson(result));


// QUERY TO GET A LIST OF ALL DISTINCT STATE IN ZIPS COLLECTION AS A SINGLE DOCUMENT.
result =
db.zips.aggregate(
[
	{
		$group: {
			_id: "$state"
		}
	},
	{
		$group: {
			_id: 0,
			"allStates": {
				$accumulator: {
					init: function() {
						return '';
					},
					initArgs: [],
					accumulate:function(state, value) {
						print('accumulating data' + state + ', ' + value);
						return value + ', ' + state;
					},
					accumulateArgs: ["$_id"],
					merge: function(state1, state2) {
						return state1 + state2;
					},
					lang: "js"
				}
			}
		}
	}
]
).toArray();
print(prefix, result);


/*



	
*/





















