INSERT INTO silver_rdm_delete_config
(
	config_id,
	rdm_list_name,
	instance_filter_column,
	instance_filter_type,
	lookup_column_name,
	text_column_name,
	active_flag
)
VALUES
(
	3,
	'RDM - Delivery Method',
	'del_meth_src_sys_inst_src_id',
	'TEXT',
	'del_meth_src_sys_inst_id',
	'del_meth_src_sys_inst_src_id',
	true
),
(
	4,
	'RDM - Form Answer Bridging',
	'form_ans_bridge_src_sys_inst_src_id',
	'TEXT',
	'form_ans_bridge_src_sys_inst_id',
	'form_ans_bridge_src_sys_inst_src_id',
	true
),
(
	5,
	'RDM - Form Question',
	'form_ques_src_sys_inst_src_id',
	'TEXT',
	'form_ques_src_sys_inst_id',
	'form_ques_src_sys_inst_src_id',
	true
),
(
	6,
	'RDM - Contract',
	'contr_src_sys_inst_src_id',
	'TEXT',
	'contr_src_sys_inst_id',
	'contr_src_sys_inst_src_id',
	true
);
