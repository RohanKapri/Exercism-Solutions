#ifndef TWO_BUCKET_H
#define TWO_BUCKET_H
#include <stdbool.h>
typedef enum {
   BUCKET_ID_1,
   BUCKET_ID_2
} bucket_id_t;
typedef unsigned int bucket_liters_t;
typedef struct {
   bool possible;
   int move_count;
   bucket_id_t goal_bucket;
   bucket_liters_t other_bucket_liters;
} bucket_result_t;
bucket_result_t measure(
   bucket_liters_t bucket_1_size,
   bucket_liters_t bucket_2_size,
   bucket_liters_t goal_volume,
   bucket_id_t start_bucket);
void InitBucket(bucket_result_t *bucketToInit, bucket_id_t startBucket, bucket_id_t otherBucket);
void FillEmptyBucket(bucket_result_t *bucketToFill, bucket_liters_t *bucketLevel, bucket_liters_t fillVolume);
bool CheckIfGoalVolumeIsInGoalBucket(bucket_result_t *bucketToFill, bucket_liters_t goalVolume);
void OtherBucketHadGoalVolume(bucket_result_t *bucketToFill);
bool CheckIfGoalVolumeIsInOtherBucket(bucket_result_t *bucketToFill, bucket_liters_t goalVolume);
bool OtherBucketIsExactlyTheGoalVolume(bucket_result_t *bucketToFill, bucket_liters_t startBucketSize, bucket_liters_t goalVolume);
bool CheckIfBothBucketsAreFull(bucket_result_t *bucketToFill, bucket_liters_t bucketOneSize);
void PourGoalBucketIntoOtherBucket(bucket_result_t *bucketToFill);
bool CheckIfEndCaseIsMet(bucket_result_t *bucketToFill, bucket_liters_t goalVolume, bucket_liters_t bucketOneSize);
void BucketAlgorithm(bucket_result_t *bucketToFill, bucket_liters_t bucketOneSize, bucket_liters_t goalVolume);
#endif