## Summary ##

This page captures the discussion about withdrawing content on the list. A feature request has been added to the Daisy Online tracker for this user story.

## Discussion ##

Johan:

As a content provider I want to withdraw (remove) an issued content from a user and the user (or the RS) should return the content the next time is logs on to the service.

I know that PDTB2 is the solution, but if the users only can stream content then I as a service provider can permit access to issued content. This could for example be used in a case where the user pays an annual (or monthly or weekly) fee to access content, and when to user forgets to pay this fee, then I can permit access to content but still let him use the service, perhaps he could find a personal announcement reminding him to pay the fee...

kenny:

If you listed a piece of content in the expired contentList, a reading system should pick this up and return the content. The only problem is that the @returnBy value would be out of synch with this return. A reading System could always check the @returnBy value when it spots content in the expired contentList, and if @returnBy value states that the content is not meant to expire at that time, inform the user that the Service has requested a withdrawl of the content. Resorting to pdtb2 for a definitive solution  to this problem is definitely the most comprehensive solution, however, my vote would be to recommend this approach (or a better approach) in the spec for those scenarios where pdtb2 is too onerous a proposition.
