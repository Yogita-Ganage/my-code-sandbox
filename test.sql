88,152 blanks are caused by NULL id_referral_in values already present in silver_sone_srcode; the Form Answer mapping itself is working as defined.


-- Exclude S1 answer rows where Care Episode ID cannot be created because IDReferralIn is missing
WHERE sc.id_referral_in IS NOT NULL
)