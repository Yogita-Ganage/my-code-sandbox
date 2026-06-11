SELECT
  id,
  email,
  member_id,
  group_id,
  reference_id,
  client_reference_number,
  bupa_membership_number,
  authorisation_number,
  account_number,
  pmi_preauthorisation_number
FROM silver_drj_users
WHERE profile_type = 'user'
  AND (
       id = '10025127-1'
    OR email = '10025127-1'
    OR member_id = '10025127-1'
    OR group_id = '10025127-1'
    OR reference_id = '10025127-1'
    OR client_reference_number = '10025127-1'
    OR bupa_membership_number = '10025127-1'
    OR authorisation_number = '10025127-1'
    OR account_number = '10025127-1'
    OR pmi_preauthorisation_number = '10025127-1'
  );



  SELECT
  id,
  email,
  member_id,
  group_id,
  reference_id,
  client_reference_number,
  bupa_membership_number,
  authorisation_number,
  account_number,
  pmi_preauthorisation_number
FROM silver_drj_users
WHERE profile_type = 'user'
  AND (
       id LIKE '%10025127%'
    OR email LIKE '%10025127%'
    OR member_id LIKE '%10025127%'
    OR group_id LIKE '%10025127%'
    OR reference_id LIKE '%10025127%'
    OR client_reference_number LIKE '%10025127%'
    OR bupa_membership_number LIKE '%10025127%'
    OR authorisation_number LIKE '%10025127%'
    OR account_number LIKE '%10025127%'
    OR pmi_preauthorisation_number LIKE '%10025127%'
  );