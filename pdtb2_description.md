# Intro #

This page serves the following three purposes:
  1. Lists key concepts of the PDTB2 spec to aid the understanding of Daisy Online implementers wishing to provide support for pdtb2 in their implementations.
  1. Describes the Daisy Online support for PDTB2.
  1. describes the contents of the sample PDTB2 package available to Daisy Online implementers.

## Key Concepts of the PDTB2 spec ##

  * for the purposes of encrypting the Daisy fileset, the pdtb2 spec groups media types into Audio, Text and Image. The audio key is used for any audio media type, and the image key for any image type.  The text key is used for any text including the text of the book and the XML markup files that are encrypted (PPF, PNCX files).  So, even an audio-only book needs and uses a text key.
  * One thing not stated in the pdtb2 spec is that text and images are encrypted in AES-CBC mode but audio is done in ECB mode (to ease random access).
  * The PDTB2 spec requires Reading Systems to have three RSA key pairs out of the factory:
    * An RSA key pair that identifies the manufacturer.
    * An RSA key pair that identifies the model of the device.
    * An RSA key pair that identifies the instance (optional for hardware Reading Systems).
  * Reading Systems sometimes come pre-installed with RSA key pairs required by a Service.
    * The DER format must always be used to encrypt the encrypted data portion of the key exchange object as specified by section 6.3.1 in the [pdtb2 spec](http://www.daisy.org/projects/pdtb/daisy-pdtb-spec.html). the PEM format must never be used for this purpose.

## Daisy Online support for PDTB2 ##

  * There is no option available to a Reading System to determine what keys are relevant to a Service when sending its keyring to a Service through the setReadingSystemAttributes operation. Thus, a reading System should always send all its keys in the keyring. The PDTB2 working group considered the scenario where a keyring would get rather large due to the number of keys present, but dismissed this issue as there are not many services using KXOs out in the field.

## Sample PDTB2 package for implementers (provided by NLS) ##

Neil:

The two .der files comprise the RSA public and private key pair.  There are three common ways of encoding such keys (DER, PEM, and .net) and PDTB-2 adds a fourth, KXO.  I used OpenSSL to generate these keys.  OpenSSL can generate DER and PEM keys but not .net or KXO.  Our encryptor can accept DER or KXO as an input format (though when using a DER format key it expects an extension of .key for some reason, thus the error message that appears in the encryption log).

I did my best to name the keys according to the DAISY naming standard, but since these keys are not associated with any particular organization besides DAISY, I used intl-daisy (rather than something like us-nls) in the name.

There are two other keys in this directory, each in three formats.  These are the two content keys (audio and text) as defined in the AO.

Remember that in the AO, each content key is encrypted with the RSA public key and must be decrypted with the RSA private key.  Further, since they are binary objects, they must be base-64 encoded in order to be carried in an XML file like the AO.

In order to prove that the book was correctly prepared, I did a "manual" decryption of each content key and then used OpenSSL with those keys to decrypt the content.  I could do this because I had the private key on hand.

The steps were:

  1. Extract a content key from the AO.  This is simply a cut-and-paste operation.  This became the **.encrypted.b64** file found in the Keys folder.
  1. base64 decode the key.  This became the **.encrypted.bin** file found in the Keys folder.
  1. Decrypt the key.  This became the **.decrypted.bin** file found in the Keys folder. You'll notice it's exactly 16 bytes in size, consistent with our 128-bit AES key length.
  1. Use the key to decrypt the content using OpenSSL
  1. Compare the decrypted content to the original

I left the keys in the keys folder to save you some effort should you decide to go through these steps yourselves.  I'd also be happy to send you the OpenSSL commands I used to do the decryption (though there is some more work that goes with it, such as deriving hex versions of the keys and initialization vector) if you want them.
