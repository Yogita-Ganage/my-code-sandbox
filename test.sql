Hi Eve, thanks, that makes sense.

With the approach I was suggesting, records where id_appointment is NULL or -1 would not be returned as NULL. They would be set to False / 0.

The multi-answer count logic would only be applied where there is a valid appointment id. So:

valid appointment id + same question/session count > 1 = True / 1
valid appointment id + count = 1 = False / 0
NULL or -1 appointment id = False / 0

I agree that trying to derive this using same question id and same day may be too loose, so I’ll keep the logic based on valid session/appointment id only.