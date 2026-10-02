-- Exclude answer rows where no matching assessment result exists, as Form Question ID is mandatory
WHERE ar.id IS NOT NULL