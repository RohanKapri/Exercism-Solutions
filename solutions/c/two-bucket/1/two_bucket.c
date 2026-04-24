// Dedicated to Shree DR.MDD

#include "two_bucket.h"
#include "two_bucket.h"
#include <stdlib.h>
#include <stdio.h>

bucket_liters_t srcVolume = 0;
bucket_liters_t dstVolume = 0;

// Forward declarations
void PrepareBucket(bucket_result_t *res, bucket_id_t srcId, bucket_id_t dstId);
void FillSourceBucket(bucket_result_t *res, bucket_liters_t *src, bucket_liters_t fillVolume);
bool IsGoalInSourceBucket(bucket_result_t *res, bucket_liters_t goal);
void SwapGoalBucket(bucket_result_t *res);
bool IsGoalInOtherBucket(bucket_result_t *res, bucket_liters_t goal);
bool IsOtherEqualGoalVolume(bucket_result_t *res, bucket_liters_t srcSize, bucket_liters_t goal);
bool AreFull(bucket_result_t *res, bucket_liters_t srcSize);
void PourSourceToOther(bucket_result_t *res);
bool IsProcessDone(bucket_result_t *res, bucket_liters_t goal, bucket_liters_t srcSize);
void PerformProcess(bucket_result_t *res, bucket_liters_t srcSize, bucket_liters_t goal);

void PrepareBucket(bucket_result_t *res, bucket_id_t srcId, bucket_id_t dstId)
{
   res->possible = false;
   res->move_count = 0;
   res->goal_bucket = srcId;
   res->other_bucket_liters = dstId;
}

void FillSourceBucket(bucket_result_t *res, bucket_liters_t *src, bucket_liters_t fillVolume)
{
   res->move_count++;
   *src = fillVolume;
}

bool IsGoalInSourceBucket(bucket_result_t *res, bucket_liters_t goal)
{
   if(srcVolume == goal)
   {
      res->possible = true;
      res->other_bucket_liters = dstVolume;
      return true;
   }
   return false;
}

void SwapGoalBucket(bucket_result_t *res)
{
   res->possible = true;
   res->other_bucket_liters = srcVolume;
   if(res->goal_bucket == BUCKET_ID_1)
   {
      res->goal_bucket = BUCKET_ID_2;
   }
   else if(res->goal_bucket == BUCKET_ID_2)
   {
      res->goal_bucket = BUCKET_ID_1;
   }
}

bool IsGoalInOtherBucket(bucket_result_t *res, bucket_liters_t goal)
{
   if(dstVolume == goal)
   {
      SwapGoalBucket(res);
      return true;
   }
   return false;
}

bool IsOtherEqualGoalVolume(bucket_result_t *res, bucket_liters_t srcSize, bucket_liters_t goal)
{
   if(res->other_bucket_liters == goal)
   {
      FillSourceBucket(res, &srcVolume, srcSize);
      FillSourceBucket(res, &dstVolume, goal);
      SwapGoalBucket(res);
      return true;
   }
   return false;
}

bool AreFull(bucket_result_t *res, bucket_liters_t srcSize)
{
   if(dstVolume == res->other_bucket_liters && srcVolume == srcSize)
   {
      res->possible = false;
      return true;
   }
   return false;
}

void PourSourceToOther(bucket_result_t *res)
{
   res->move_count++;
   dstVolume += srcVolume;
   if(dstVolume > res->other_bucket_liters)
   {
      srcVolume = dstVolume - res->other_bucket_liters;
      dstVolume = res->other_bucket_liters;
   }
   else
   {
      srcVolume = 0;
   }
}

bool IsProcessDone(bucket_result_t *res, bucket_liters_t goal, bucket_liters_t srcSize)
{
   if(IsGoalInSourceBucket(res, goal) == true)
   {
      return true;
   }
   else if(IsGoalInOtherBucket(res, goal) == true)
   {
      return true;
   }
   else if(AreFull(res, srcSize) == true)
   {
      return true;
   }
   return false;
}

void PerformProcess(bucket_result_t *res, bucket_liters_t srcSize, bucket_liters_t goal)
{
   if(IsProcessDone(res, goal, srcSize) == true)
   {
      return;
   }
   if(srcVolume == 0)
   {
      FillSourceBucket(res, &srcVolume, srcSize);
   }
   else if(dstVolume == 0)
   {
      PourSourceToOther(res);
   }
   if(IsProcessDone(res, goal, srcSize) == true)
   {
      return;
   }
   if(dstVolume == res->other_bucket_liters)
   {
      res->move_count++;
      dstVolume = 0;
   }
   if(srcVolume == srcSize)
   {
      PourSourceToOther(res);
   }
   PerformProcess(res, srcSize, goal);
   return;
}

bucket_result_t measure(
   bucket_liters_t srcSize,
   bucket_liters_t dstSize,
   bucket_liters_t goal,
   bucket_id_t srcId)
{
   srcVolume = 0;
   dstVolume = 0;

   bucket_result_t *res = (bucket_result_t *)malloc(sizeof(bucket_result_t));

   if(goal > srcSize && goal > dstSize)
   {
      res->possible = false;
      return *res;
   }

   if(srcId == BUCKET_ID_1)
   {
      PrepareBucket(res, srcId, dstSize);
      if(IsOtherEqualGoalVolume(res, srcSize, goal) == false)
      {
         PerformProcess(res, srcSize, goal);
      }
   }
   else
   {
      PrepareBucket(res, srcId, srcSize);
      if(IsOtherEqualGoalVolume(res, srcSize, goal) == false)
      {
         PerformProcess(res, dstSize, goal);
      }
   }
   return *res;
}
