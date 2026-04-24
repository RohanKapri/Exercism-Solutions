// Dedicated to Shree DR.MDD

#include "binary_search_tree.h"
#include "binary_search_tree.h"
#include <stdlib.h>

static node_t *CreateNode(int val);
static node_t *InsertNode(int val, node_t *root);
static int FillArray(int idx, node_t *root, int *arr);

node_t *build_tree(int *arr, size_t arr_len)
{
   int total = arr_len;
   int idx = 0;
   node_t *root = malloc(sizeof(struct node));

   free_tree(root);

   for (idx = 0; idx < total; idx++) 
   {
      root = InsertNode(arr[idx], root);
   }

   return root;
}

static node_t *CreateNode(int val)
{
   node_t *item = malloc(sizeof(struct node));

   item->data = val;
   item->right = NULL;
   item->left = NULL;

   return item;
}

static node_t *InsertNode(int val, node_t *root)
{
   if (root->data == 0) 
   {
      return CreateNode(val);
   }

   if (root->data >= val) 
   {
      if (root->left) 
      {
         InsertNode(val, root->left);
      } 
      else 
      {
         root->left = CreateNode(val);
      }
   } 
   if (root->data < val) 
   {
      if (root->right) 
      {
         InsertNode(val, root->right);
      } 
      else 
      {
         root->right = CreateNode(val);
      }
   }

   return root;
}

void free_tree(node_t *root)
{
   root->data = 0;
   root->right = NULL;
   root->left = NULL;
}

int *sorted_data(node_t *root)
{
   int *arr = (int *)malloc(100 * sizeof(int));

   int idx = 0;

   FillArray(idx, root, arr);

   return arr;
}

static int FillArray(int idx, node_t *root, int *arr)
{
   if (root->left) 
   {
      idx = FillArray(idx, root->left, arr);
   }

   arr[idx++] = root->data;

   if (root->right) 
   {
      idx = FillArray(idx, root->right, arr);
   }

   return idx;
}
