## Summary ##

This page captures the discussion on the list about renewing content using the Daisy Online protocol. A feature request has been added to the Daisy Online tracker on the DC website for this user story.

## Discussion ##

Johan:


As a user I want to extend (renew) the time of return for a borrowable content that has been issued, without having to return the content. The method for is out-of-band. In future version of the spec we could consider incorporating this feature into the protocol.

At first I thought that the @returnBy attribute was intended for the user, but it turns out it is for the RS only. Secondly, I would like to communicate the time of return to the user via the @returnBy attribute but since that cannot be changed once a content is issued, I cannot use it.

Johan:

A correction to is in place here. The @returnBy attribute is intended for both the user and the RS, not the RS as I believed at first.

The problem is that I can't change the value of @returnBy since it cannot be changed for a content that has been issued (see section 6.10). Thus, I could change the value of @returnBy if I also set the @lastModifiedDate attribute and update it's value every time @returnBy is updated. Am I allowed to do this? If yes, then we have the clarify it in the spec.

Nick:

I'm just thinking out loud here but can't your re-issue requirement be handled by the reading system calling issueContent again.

I don't think we say what happens if issueContent is called with an id of content already issued so the service could change the returnBy attribute of the resources.


kenny:

Following on from Nick's suggestion, if a Reading System was to call the issue content operation for content that was already issued, we could position this invokation to signify a renewal request. The retrieval of the Resources type then, through the invokation of the getResources operation, would return the list of resources with the updated @returnBy value.


Johan:

Calling issueContent again for a content that already has been issued could indicate a renewal request. There may also be cases where the renewal is handled via an out-of-band mechanism and/or the user is not able to manually issue content via the reading system. In this case the reading system can't know which content to re-issue and re-issuing all contents every time an active session has been established is not a suitable solution. Another approach would be to call getContentResources again and compare the response with what might have been stored by the reading system.


kenny:

If I understood correctly, your user story requires that content should not only be renewable through the protocol itself, but also through an out-of-band mechanism.

For the former where the renewal is affected using the protocol itself, we could position an invokation of the issueContent operation for content that has already been issued to constitute a renewal request, as I suggested previously. We could then define a Renewal operation sequence as:

1. Invoke issueContent for content that has already been issued to request renewal of the content.


2. Invoke getContentResources to retrieve the resources with updated @returnBy values.


We could also make this explicit by adding a new renewContent operation, which would make the Renewal operation sequence:

1. Invoke renewContent with the ID of the content that needs to be renewed.

2. Invoke getContentResources to retrieve the resources with updated @returnBy values.



As for the latter (i.e. an out-of-band mechanism to renew content), the RS needs a way to discover that some content has been renewed when it connects to the Service. I don't think the three contentLists we have in the protocol right now i.e. new, issued and expired can convey this information. One solution that comes to mind is:

We introduce a new contentList called renewed (or something to this affect) that lists renewed content. An RS would then invoke getContentResources to retrieve the resources with the updated @returnBy values.

The renewal information retrieval operation sequence for the out-of-band mechanism of renewal would then be:

1. Invoke getContentList with the id "renewed" to retrieve the list of content that has been renewed through an out-of-band mechanism.


2. Invoke getContentResources to retrieve the resources with updated @returnBy values.