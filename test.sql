Initially, the cprod_src_id was implemented using the corresponding Rota ID and Rota Slot ID, following the attribute definition. During validation, I found that the resulting cprod_src_id was not unique. The same Rota ID + Rota Slot ID combination could map to different cprod_src_name values because SRAppointment.RotaType can vary for the same Rota ID.

I validated this against the SONE source tables and confirmed that this was causing the duplicate/non-unique source IDs.

I then checked this with Eve, and she confirmed that the cprod_src_id should follow the same logic as cprod_src_name, as the ID should represent the value sitting behind the name.

Based on this confirmation, I have updated the SONE cprod_src_id logic to use the same RotaType + RotaSlotType combination as cprod_src_name.

Final logic:

cprod_src_name = RotaType + RotaSlotType
cprod_src_id = RotaType + RotaSlotType
Existing SONE appointment → Rota Slot join remains unchanged.

Validation will be completed to confirm the updated source IDs are unique and aligned with the source names.