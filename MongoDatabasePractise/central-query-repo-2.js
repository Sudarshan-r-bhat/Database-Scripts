// This file will contain all the QUERY OPERATIONS that will ever be done from 17th August 2021.
/*
	TO EXECUTE THIS FILE FROM CMD:
		$ mongo --eval "load(ls()[2].slice(2))"
		
	TO OUTPUT THE RESULT OF QUERY:
		. convert the result to array and store it in a variable.
		. use printjson() function to log the result.
	TO RUN SCRIPT FROM WITHIN THE MONGOSHELL:
		$ load(ls()[1].slice(2));
		
	note: the way you query the embeded object and array are the same.
	
		
		
*/

const prefix='[ log ]';
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



query = 
	db.testCollection.aggregate([
		{$unwind: "$numbers"},
		{
			$group: {
				_id: "$_id",
				avg: {$avg: "$numbers"}
			} 
		}	
	]);

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
	
print(prefix, query);
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

print(prefix, tojson(query));


// SWITCH STATEMENT IN UPDATE QUERY
print(prefix, 'SWITCH STATEMENT IN UPDATE QUERY');
query = 
	db.testCollection.updateMany(
		{}, 
		[
			{ $set: { size: { $switch: { 
				branches: [
				{case: {$gte: [10, {s: {$size: "$numbers"}}]}, then: "more than 10" }, 
				{case: {$gte: [6, {s: {$size: "$numbers"}}]}, then: "more than six"},
				{case: {$gte: [3, {s: {$size: "$numbers"}}]}, then: "more than 3"}
			], 
				default: "less than 3"
			}} }}
	]);
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
print(prefix, tojson(query));
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
query =
	db.testCollection.aggregate([
	{
		$project: {
			status: {
				$gte : [  {$size: "$numbers"}, 3  ]
			}
		}
	}
	]);
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
print(prefix, query);
print(result);


// QUERY TO TRANSFORM THE DOCUMENT. USING $addFields, $map : input: as: in
query =
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
print(prefix, tojson(query));
print(prefix, tojson(result));











