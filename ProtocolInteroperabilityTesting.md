

# Introduction #

This report summarizes the interoperability testing of the protocol, that is, the demonstration of independent compatible implementations of each feature in the specification.  These test cases are not comprehensive; in particular, the underlying technologies are not tested.

# Conventions #

Operation calls are represented in a C-like format, e.g. `getContentList(`_listId_`, 0, -1)` represents a call to `getContentList` with parameters _listId_ (a variable—see below), `0` and `-1`.

## Variables ##

To allow for testing with existing Reading Systems and Services, variables are given in _italics_ that may be assigned appropriate values when carrying out the tests.

## Preconditions ##

An initialized session established between the Reading System and the Service is a precondition of every test below except those in sections 4.2.1.

Preconditions for individual tests are marked (PRE:).

# 4. Protocol Fundamentals #

## 4.1. Service Models ##

### 4.1.1. Lending Model ###

Variables
  * _conId_: The identifier of a valid borrowable Content item on the Service.
  * _badId_: A string which is not the identifier of a valid Content item on the Service.
  * _forbId_: The identifier of a valid borrowable Content item on the Service, which is not issued to the Reading System's User.

Tests
  1. **Indicate lending model**: The Reading System calls `getContentMetadata(`_conId_`)`. The Service returns a `contentMetadata` object with the `requiresReturn` attribute set to `true`.
  1. **Offer issued list**: (PRE: Content with identifier _conId_ has been issued to the Reading Systems's User.) The Reading System calls `getContentList("issued", 0, -1)`. The Service returns a `contentList` with the identifier `issued` containing a `contentItem` with the identifier _conId_.
  1. **Return Content**: (PRE: Content with identifier _conId_ has been issued to the Reading Systems's User.) The Reading System calls `returnContent(`_conId_`)`. The Service returns `true`.
  1. **Return invalid Content**: The Reading System calls `returnContent(`_badId_`)`. The Service throws an `invalidParameter` fault.
  1. **Return Content not in hand**: The Reading System calls `returnContent(`_forbId_`)`. The Service throws an `invalidParameter` fault.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.1.1.1 |  |  |  |  |
| 4.1.1.2 |  |  |  |  |
| 4.1.1.3 | — | — | — | Covered in System tests 4.1 and 4.2. |
| 4.1.1.4 |  |  |  |  |
| 4.1.1.5 |  |  |  |  |

### 4.1.2. Acquisition Model ###

Variables
  * _conId_: The identifier of a valid purchasable Content item on the Service.
Tests
  1. **Indicate acquisition model**: The Reading System calls `getContentMetadata(`_conId_`)`. The Service returns a `contentMetadata` object with the `requiresReturn` attribute set to `false`.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.1.2.1 |  |  |  |  |

## 4.2. User Authentication and Session Management ##

### 4.2.1. Session Initialization ###

Variables
  * _user_: A valid username on the Service.
  * _pass_: A valid password for _user_.
  * _baduser_: An invalid username on the Service.
  * _badpass_: An invalid password for _user_.
  * _rSA_: A valid `readingSystemAttributes` object representing the Reading System's attributes.
  * _badRSA_: An invalid `readingSystemAttribute` object representing the Reading System's attributes.

Tests
  1. Before initialization:
    1. **No active session**: The Reading Systems calls `getServiceAttributes()`. The Service throws a `noActiveSession` fault.
  1. During initialization:
    1. logOn:
      1. **Valid log on**: The Reading System calls `logOn(`_user_`, `_pass_`)`. The Service returns `true` and sets a session cookie.
      1. **Invalid user**: The Reading System calls `logOn(`_baduser_`, `_pass_`)`. The Service returns `false`.
      1. **Invalid password**: The Reading System calls `logOn(`_user_`, `_badpass_`)`. The Service returns `false`.
    1. getServiceAttributes:
      1. **Get serviceAttributes**: (PRE: A successful logon response has been received.) The Reading System calls `getServiceAttributes()`. The Service returns a `serviceAttributes` object.
      1. **Log on**: (PRE: A successful logon response has been received.) The Reading System calls `logOn(`_user_, _pass_`)`. The Service returns `true`.
      1. **Set readingSystemsAttributes**: (PRE: A successful logon response has been received.) The Reading System calls `setReadingSystemsAttributes(`_rSA_`)`. The Service throws an `invalidOperation` fault.
    1. setReadingSystemAttributes:
      1. **Set readingSystemAttributes**: (PRE: A successful getServiceAttributes response has been received.) The Reading Systems calls `setReadingSystemAttributes(`_rSA_`)`: The Service returns `true`.
      1. **Set invalid readingSystemAttributes**: (PRE: A successful getServiceAttributes response has been received.) The Reading Systems calls `setReadingSystemAttributes(`_badRSA_`)`: The Service throws an `invalidParameter` fault.
      1. **Log on**: (PRE: A successful getServiceAttributes response has been received.) The Reading System calls `logOn(`_user_, _pass_`)`. The Service returns `true`.
      1. **Get serviceAttributes**: (PRE: A successful getServiceAttributes response has been received.) The Reading Systems calls `getServiceAttributes()`: The Service throws an `invalidOperation` fault.
  1. After initialization:
    1. **Get serviceAttributes**: (PRE: A session has been initialized.) The Reading System calls `getServiceAttributes()`. The Service returns a `serviceAttrbitues` object.
    1. **Set readingSystemAttributes**: (PRE: A session has been initialized.) The Reading System calls `setReadingSystemAttributes(`_rSA_`)`. The Service returns `true`.
    1. **Reinitialization**: (PRE: A session has been initialized.) The Reading System calls `logOn(`_user_, _pass_`)`. The Service returns `true`. The Reading System calls `getServiceAnnouncements()`. The Service throws a `noActiveSession` fault.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.2.1.1.1 |  |  |  |  |
| 4.2.1.2.1.1 |  |  |  |  |
| 4.2.1.2.1.2 |  |  |  |  |
| 4.2.1.2.1.3 |  |  |  |  |
| 4.2.1.2.2.1 |  |  |  |  |
| 4.2.1.2.2.2 |  |  |  |  |
| 4.2.1.2.2.3 |  |  |  |  |
| 4.2.1.2.3.1 |  |  |  |  |
| 4.2.1.2.3.2 |  |  |  |  |
| 4.2.1.2.3.3 |  |  |  |  |
| 4.2.1.2.3.4 |  |  |  |  |
| 4.2.1.3.1 |  |  |  |  |
| 4.2.1.3.2 |  |  |  |  |
| 4.2.1.3.3 |  |  |  |  |

### 4.2.2. Session Duration ###

Tests
  1. **Session terminated by Reading System**: The Reading System calls `logOff`. The Service return `true`. The Reading System calls `getServiceAttributes()`. The Service returns a `noActiveSession` fault.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.2.2.1 | — | — | — | Covered in System test 6.1 and 25.1 |

## 4.3. Content Selection Methods ##

_TODO: write negative test cases for segmented getContentLists, i.e. getContentList("new", 4, 2)_

### 4.3.1. Out-of-band Content Selection Method ###

Tests
  1. **New items**: (PRE: The Service supports Out-of-band Content selection.) The Reading System calls `getContentList("new", 0, -1)`. The Service returns a `contentList` with the identifier `new`.  No `contentItem`'s `id` is the identifier of an issued Content item.
  1. **Issued items**: (PRE: The Service offers some Content under a lending model.) The Reading System calls `getContentList("issued", 0, -1)`. The Service returns a `contentList` with the identifier `issued`.  Each `contentItem`'s `id` is the identifier of an issued Content item.
  1. **Expired items**: (PRE: The Service provides the "expired" `contentList`.) The Reading System calls `getContentList("expired", 0, -1)`.  The Service returns a `contentList` with the identifier `expired`.  Each `contentItem`'s `id` is the identifier of an issued Content item.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.3.1.1 | — | — | — | Covered in System test 18.1. |
| 4.3.1.2 | — | — | — | Covered in System test 18.1. |
| 4.3.1.3 | — | — | — | Covered in System test 18.1. |

### 4.3.2. Browse Content Selection Method ###

Variables
  * _listId_: The identifier of a `contentList` on the Service that is not "new", "issued" or "expired".
  * _first_: The index of a `contentItem` in the _listId_ `contentList`, greater or equal than 0.
  * _last_: The index of a `contentItem` in the _listId_ `contentList`, greater than _first_.

Tests
  1. **Browse items**: (PRE: The Service supports Browse Content selection.) The Reading System calls `getContentList(`_listId_`, 0, -1)`. The Service returns a `contentList` with the identifier _listId_.
  1. **Segmented list**: (PRE: The Service supports Browse Content selection.) The Reading System calls `getContentList(`_listId_`, `_first_`, `_last_`)`. The Service returns a `contentList` with the identifier _listId_.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.3.2.1 |  |  |  |  |
| 4.3.2.2 |  |  |  |  |

## 4.4. Issuing and Transfer of Content ##

### 4.4.1. Content Retrieval Sequence ###

Variables
  * _conId_: The identifier of a valid Content item on the Service.
  * _badId_: A string which is not the identifier of a valid Content item on the Service.
  * _forbId_: The identifier of a valid Content item on the Service, which the Service will not allow access to.

Tests
  1. getContentMetadata:
    1. **Get Content metadata**: The Reading System calls `getContentMetadata(`_conId_`)`. The Service returns a valid `contentMetadata` object, whose `dc:identifier` metadata value equals _conId_. (JA: is this a requirement?. I thought that the service could use arbitrary ids for contents)
    1. **Get invalid Content metadata**: The Reading System calls `getContentMetadata(`_badId_`)`. The Service throws an `invalidParameter` fault.
    1. **Get Content metadata for a Content that is not accessible to the Reading System's User**: The Reading System calls `getContentMetadata(`_forbId_`)`. The Service returns a valid `contentMetadata` object.
  1. issueContent:
    1. **Issue Content**: The Reading System calls `issueContent(`_conId_`)`. The Service returns `true`.
    1. **Issue invalid Content**: The Reading System calls `issueContent(`_badId_`)`. The Service returns `false` or throws a fault.
    1. **Issue forbidden Content**: The Reading System calls `issueContent(`_forbId_`)`. The Service returns `false` or throws a fault.
  1. getContentResources:
    1. **Get Content resources**: (PRE: Content with identifier _conId_ has been issued to the Reading Systems's User.) The Reading System calls `getContentResources(`_conId_`)`. The Service returns a valid `contentMetadata` object, whose `dc:identifier` metadata value equals _conId_.
    1. **Get invalid Content resources**: The Reading System calls `getContentResources(`_badId_`)`. The Service throws an `invalidParameter` fault.
    1. **Get forbidden Content resources**: The Reading System calls `getContentResources(`_forbId_`)`. The Service throws an `invalidParameter` fault.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.4.1.1.1 | — | — | — | Covered in System test 11.1. |
| 4.4.1.1.2 |  |  |  |  |
| 4.4.1.1.3 |  |  |  |  |
| 4.4.1.2.1 | — | — | — | Covered in System test 14.1. |
| 4.4.1.2.2 |  |  |  |  |
| 4.4.1.2.3 | — | — | — | Covered in System test 14.2. |
| 4.4.1.3.1 | — | — | — | Covered in System test 14.1. |
| 4.4.1.3.2 |  |  |  |  |
| 4.4.1.3.3 | — | — | — | Covered in System test 14.2. |

### 4.4.2. Downloading and Streaming of Content ###

### 4.4.3. Publishing Updates and Installments ###

### 4.4.4. Rights management ###

Variables
  * _goodkey_: The name of a key available on the Service.
  * _badkey_: A string which is not the name of a key available on the Service.
  * _forbkey_: The name of a key available on the Service, which is not permitted to be sent to the Reading System.

Tests
  1. **Get a key**: (PRE: In the most recent call to `setReadingSystemAttributes`, the `readingSystemAttributes` object passed included a `keyRing` element with an `item` child whose value is the name of a key (_userkey_) which _goodkey_ is permitted to be encrypted with.) The Reading System calls `getKeyExchangeObject(`_goodkey_`)`. The Service returns a valid `KeyExchange` object containing _goodkey_ encrypted with _userkey_.
  1. **Get a key, invalid user keys**: (PRE: In the most recent call to `setReadingSystemAttributes`, the `readingSystemAttributes` object passed included a `keyRing` element with an `item` child whose value is the name of a key (_userkey_) which _goodkey_ is not permitted to be encrypted with.) The Reading System calls `getKeyExchangeObject(`_goodkey_`)`. The Service throws an `invalidParameter` fault.
  1. **Get a key, no user keys**: (PRE: In the most recent call to `setReadingSystemAttributes`, the `readingSystemAttributes` object passed did not include a `keyRing` element.) The Reading System calls `getKeyExchangeObject(`_goodkey_`)`. The Service throws an `invalidParameter` fault.
  1. **Get an invalid key**: The Reading System calls `getKeyExchangeObject(`_badkey_`)`.  The Service throws an `invalidParameter` fault.
  1. **Get a forbidden key**: The Reading System calls `getKeyExchangeObject(`_forbkey_`)`.  The Service throws an `invalidParameter` fault.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.4.4.1 | — | — | — | Covered in System test 11.2. |
| 4.4.4.2 |  |  |  |  |
| 4.4.4.3 |  |  |  |  |
| 4.4.4.4 |  |  |  |  |
| 4.4.4.5 | — | — | — | Covered in System test 11.3. |

## 4.5. Service Announcements ##

### 4.5.1. New Announcements ###

Tests
  1. **Get Service announcements**: (PRE: The Service supports `getServiceAnnouncements` operation). The Reading System calls `getServiceAnnouncements()`. The Service returns a valid `announcements` object.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.5.1.1 | — | — | — | Covered in System test 29.1. |

### 4.5.2. Read Announcements ###

Variables
  * _readItems_: A valid `read` object, whose `item`s have the values of announcements on the Service.
  * _badReadItems_: A valid `read` object, whose `item`s do not have the values of announcements on the Service.

Tests
  1. **Mark as read**: (PRE: The Service supports `markAnnouncementsAsRead` operation). The Reading System calls `markAnnouncementsAsRead(`_readItems_`)`.  The Service returns `true`.
  1. **Mark invalid announcement as read**: (PRE: The Service supports `markAnnouncementsAsRead` operation). The Reading System calls `markAnnouncementsAsRead(`_badReadItems_`)`.  The Service throws an `invalidParameter` fault.


| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.5.2.1 | — | — | — | Covered in System test 29.2. |
| 4.5.2.1 |  |  |  |  |

## 4.6. Bookmarks ##

Variables
  * _conId_: The identifier of a Content item.
  * _badId_: A string for which it does not exist a bookmark on the Service.
  * _bmS_: A `bookmarkSet` object whose `uid` element's value is _conId_. (JA: is this a requirement. See tc 4.4.1.1.1)

Tests
  1. **Set bookmarks**: (PRE: The Service supports `setBoomarks` operation). The Reading System calls `setBookmarks(`_conId_`, `_bmS_`)`. The Service returns `true`.
  1. **Get bookmarks**: (PRE: The Servie supports `getBookmark` operation) The Reading System calls `getBookmarks(`_conId_`)`. The Service returns a valid `bookmarkSet` object whose `uid` element's value is _conId_.
  1. **Get invalid bookmarks**: (PRE: The Servie supports `getBookmark` operation) The Reading System calls `getBookmarks(`_badId_`)`. The Service throws an `invalidParameter` fault.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.6.1 | — | — | — | Covered in System test 13.1. |
| 4.6.2 | — | — | — | Covered in System tests 3.1 and 13.1. |
| 4.6.3 |  |  |  |  |

## 4.7. Dynamic Menus ##

### 4.7.1. Support ###

### 4.7.2. Root Question ###

Variables
  * _defaultUR_: A `userResponses` object, with one `userResponse` child whose `questionID` attribute is `default` and has no children.

Tests
  1. **Get the root menu**: The Reading Systems calls `getQuestions(`_defaultUR_`)`. The Service returns a valid `questions` object.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.7.2.1 |  |  |  |  |

### 4.7.3. Navigation ###

Variables
  * _numericId_: The identifier of an `inputQuestion` on the Service that accepts numeric input.
  * _alphaId_: The identifier of an `inputQuestion` on the Service that accepts alphanumeric input.
  * _audioId_: The identifier of an `inputQuestion` on the Service that accepts audio input.
  * _multiId_: The identifier of a `multipleChoiceQuestion` on the Service whose `allowMultipleSelections` attribute is `false`.
  * _multiMultiId_: The identifier of a `multipleChoiceQuestion` on the Service whose `allowMultipleSelections` attribute is `true` and has multiple `choice` children.
  * _numericUR_: A `userResponses` object, with one `userResponse` child whose `questionID` attribute is _numericId_, whose `value` attribute is a numeric string and has no children.
  * _alphaUR_: A `userResponses` object, with one `userResponse` child whose `questionID` attribute is _alphaId_, whose `value` attribute is an alphanumeric string and has no children.
  * _audioUR_: A `userResponses` object, with one `userResponse` child whose `questionID` attribute is _audioId_ and has one `data` child whose value is a RIFF WAVE binary.
  * _multiUR_: A `userResponses` object, with one `userResponse` child whose `questionID` attribute is _multiId_, whose `value` attribute is a valid response to the `multiId` question and has no children.
  * _multiMultiUR_: A `userResponses` object, with multiple `userResponse` children whose `questionID` attributes are _multiId_, whose `value` attributes are different valid responses to the `multiId` question and have no children.
  * _comboUR_: A `userResponses` object, with four `userResponse` children, namely the `userResponse` children of _numericUR_, _alphaUR_, _audioUR_ and _multiUR_.

Tests
  1. **Numeric response**: (PRE: _numericId_ is the identifier of an `inputQuestion` returned in some call to `getQuestions` in this session.) The Reading Systems calls `getQuestions(`_numericUR_`)`. The Service returns a valid `questions` object.
  1. **Alphanumeric response**: (PRE: _alphaId_ is the identifier of an `inputQuestion` returned in some call to `getQuestions` in this session.) The Reading Systems calls `getQuestions(`_alphaUR_`)`. The Service returns a valid `questions` object.
  1. **Audio response**: (PRE: _audioId_ is the identifier of an `inputQuestion` returned in some call to `getQuestions` in this session.) The Reading Systems calls `getQuestions(`_audioUR_`)`. The Service returns a valid `questions` object.
  1. **Multiple choice response**: (PRE: _multiId_ is the identifier of a `multipleChoiceQuestion` returned in some call to `getQuestions` in this session.) The Reading Systems calls `getQuestions(`_multiUR_`)`. The Service returns a valid `questions` object.
  1. **Multiple multiple choice response**: (PRE: _multiMultiId_ is the identifier of a `multipleChoiceQuestion` returned in some call to `getQuestions` in this session.) The Reading Systems calls `getQuestions(`_multiMultiUR_`)`. The Service returns a valid `questions` object.
  1. **Combination response**:  (PRE: _numericId_, _alphaId_, _audioId_ and _multiId_ are the identifiers of questions returned in some call to `getQuestions` in this session.) The Reading Systems calls `getQuestions(`_comboUR_`)`. The Service returns a valid `questions` object.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.7.3.1 |  |  |  |  |
| 4.7.3.2 |  |  |  |  |
| 4.7.3.3 |  |  |  |  |
| 4.7.3.4 |  |  |  |  |
| 4.7.3.5 |  |  |  |  |
| 4.7.3.6 |  |  |  |  |

### 4.7.4. Question Types ###

### 4.7.5. End Points ###

Variables
  * _labelUR_: A `userResponses` object, which will result in an endpoint in the menu sequence.
  * _conListRefUR_: A `userResponses` object, which will result in an endpoint in the menu sequence.

Test
  1. **Get label endpoint**: (PRE: The menu sequence in the Service contains a label endpoint.) The Reading Systems calls `getQuestions(`_labelUR_`)`. The Service returns a `questions` object, with one `label` child and has no children.
  1. **Get content list reference**: (PRE: The menu sequence in the Service contains a content list reference.) The Reading Systems calls `getQuestions(`_conListRefUR_`)`. The Service returns a `questions` object, with one `contentListRef` child and has no children.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.7.5.1 |  |  |  |  |
| 4.7.5.2 |  |  |  |  |

### 4.7.6. Reserved IDs ###

Variables
  * _defaultUR_: A `userResponses` object, with one `userResponse` child whose `questionID` attribute is `default` and has no children.
  * _searchUR_: A `userResponses` object, with one `userResponse` child whose `questionID` attribute is `search` and has no children.
  * _backUR_: A `userResponses` object, with one `userResponse` child whose `questionID` attribute is `back` and has no children.

Tests
  1. **Get the root menu**: The Reading Systems calls `getQuestions(`_defaultUR_`)`. The Service returns a valid `questions` object.
  1. **Get the search menu**: (PRE: The Service supports `search`.) The Reading Systems calls `getQuestions(`_searchUR_`)`. The Service returns a valid `questions` object.
  1. **Go back**: (PRE: The Service supports `back` and the Reading System has previously responded to a question.) The Reading System calls `getQuestions(`_backUR_`)`. The Service returns a valid `questions` object which is identical to the previous question presented to the Reading System.
  1. **No back to go to**: (PRE: The Service supports `back` and no previous calls to `getQuestions` has been made by the Reading System.) The Reading System calls `getQuestions(`_backUR_`)`. The Service throws an `invalidParameter` fault.

| Test case | Client | Server | Result | Details |
|:----------|:-------|:-------|:-------|:--------|
| 4.7.6.1 | — | — | — | Covered in 4.7.2.1 |
| 4.7.6.2 |  |  |  |  |
| 4.7.6.3 |  |  |  |  |
| 4.7.6.4 |  |  |  |  |