Updated WIP z_src_is_active logic as per the latest attribute definition.

The earlier implementation was only checking “case raised in error” / “BNSSG- Case Raised In Error”. During rework, the updated definition was reviewed and “Raised in error” was also added to the WIP active flag logic.

Now, any WIP care episode with activity service description as “case raised in error”, “raised in error”, or “BNSSG- Case Raised In Error” will be marked as inactive with z_src_is_active = 0. Used LOWER(TRIM()) to handle case differences.