#include <iostream>

using namespace std;
// https://leetcode.com/problems/remove-duplicates-from-sorted-list/

/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */

struct ListNode {
	int val;
	ListNode *next;
	ListNode( int x ) : val( x ), next( NULL ) {}
};


class Solution
{
public:
	ListNode *deleteDuplicates( ListNode *head )
	{
		if(head == NULL || head->next ==NULL)
			return head;
		int tmp = head->val;
		ListNode * cur = head->next, *pre = head;

		while(cur != NULL){
			if(pre->val == cur->val){
				pre->next = cur->next;
				delete cur;
				cur = pre->next;
			}else{
				pre = cur;
				cur = cur->next;
			}
		}
		return head;
	}
};


int main(int argc, char const *argv[])
{
	/* code */
	return 0;
}