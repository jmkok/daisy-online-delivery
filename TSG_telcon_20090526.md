## Present ##

Simon, Dominik, George, Kenny (Scribe), Hiro.

## Regrets ##

Markus, Jelle, Geoff.

## Decisions ##

**Streaming protocols such as RTSP are out of scope for this version of the Daisy Online Delivery Standard.**

**We will stick with soap for this version of the Standard.**

## Action Item Summary ##

### New Action Items ###
  * @markus put all classic TSG req docs on SVN

### Previous Unfinished Action Items ###
  * @kenny enter atomic issues reported so far to google code tracker (Geoff, Markus and Kenny have recorded all reported issues in the issue tracker)
  * @markus, @kenny draft one or several hypotheses on spec documents reorganization

## Minutes ##

Telcon recording audio file name is 20090526

kenny: Any thoughts on  the comments posted

simon: I don't see getResource as a problem. I understand the concern that people have. If an organisation wants to use getResource knowing the 33% overhead, the player will just be slower.

simon: In terms of Reading System development, getResource is not much of a problem because we already use soap functions. If we keep http, I don't see why we should drop the getResource function.

george: With small files there might be a 33% overhead. It might not be as bad with large files. I would like confirmation that it is indeed 33%.

kenny: In my view, it should be the reading system vendors's vote that decides whether getResource should be kept or not. This is because the Service Providers can stay clear of the getResource function if they  so wish.

george: I see Markus's concern that there should only be one way of doing something in a spec.

kenny: To all reading system vendors, will implementing both getResource and direct http/https downloading/streaming be a significant cost to you?

simon and hiro: We don't believe implementing both approaches is an unreasonable cost. From a pure development perspective, there should be no problems, the cost might be incurred by cpu cycles.

simon: Like George says, we should have empirical evidence before we make a definitive decision.

(The issue was parked due to Geoff, Jelle and Markus not being available, and pending further empirical evidence.)

kenny: Should we be using streaming protocol such as rtsp?

hiro: We already have a protocol called net plextalk. http is sufficient for streaming.

simon: As long as resuming downloads is supported via http/https, rtsp might be something nice, but it is perhaps an overkill for now. Its not worth the effort to go for such a protocol at this stage.

decision: There was consensus that streaming protocols such as RTSP are out of scope for this version of the Daisy Online Delivery Standard.

kenny: Perhaps this could be a part of version 2.

kenny: Are there any comments that you would like to make on the requirements doc?

kenny: We intend to have all comments recorded in the issue tracker by the next telecon.

dominik: We want the libraries to tell us what they want.

simon: A lot of comments that i have seen thus far were about the documentation not being clear, rather than the spec itself. Because I was there myself, I don't see the problem with the reported issues.

dominik: This is a common problem with specs, as people in the spec have all the info.

dominik: We should reach out and ask people if they have any comments. If people say they don't have any comments, we don't want a lack of comments affecting the adoption of the standard.

george: It seems the spec is going to be implemented by certain entities and then other entities will follow. The libraries that deal with students are looking at using the spec differently than leisure libraries.

kenny: How do we reach out to people as you suggested Dominik?

dominik: Perhaps we can post an email to the general daisy list asking people for their comments.

george: We could do a survey of full members and ask them who is thinking of implementing this spec. We don't know about a lot of different organisations planning to implement this spec.

dominik: We have a big concern that we might create something and people might decide to go their own way. Its important that everyone's requirements be included. This has already happened with other specs.

george: A primer is necessary as many organisations may not have the technical numbers, and might have to hire external connsultants to understand the spec.

kenny: How would you like the comments dealt with. On the call or list?

dominik: We need to review comments offline. Lets resolve the majority of the comments on the list. Perhaps we can resolve comments via voting. A call could then come in handy for those items that cannot be resolved on the list.

george: I have seen a few times an issue dividing a wg into camps. We should avoid that as much as possible. Lets resolve the controversial ones on the call, and others on the list.

kenny: Are we decided on soap?

simon: We chose to go with soap. We discussed it a lot. I think its too late to change.

dominik: It to me would be like changing html and smil in daisy. Unless there is a very compelling argument, we should leave it as is.

hiro: We don't have any problems with soap. we can use soap or rest. we hav already developed using soap, so lets stick with it.

decision: There was consensus that we would stick with soap for this version of the Daisy Online Delivery Standard.

kenny: What does everyone think of a face to face?

dominik: face to face meetings are always useful. We need to look at the practicalities. Humanware will be happy to host the group for the face to face.

george: Depends on the amount of work to be done. Perhaps a writers group could be another option. We got four people together for the structure guidelines, and we got so much done.

## Next concall ##
Next call is at 14:00 UTC on the  9th of June.
