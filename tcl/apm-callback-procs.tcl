# packages/course-catalog/tcl/apm-callbacks-procs.tcl 

ad_library {
    
    APM callback for dotlrn catalog
    
    @author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation-date 2005-01-27
}

namespace eval dotlrn-catalog {}

ad_proc -private dotlrn-catalog::package_install {
} {
    create the CR type datamodel for the course catalog
    
    @author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation-date 2005-01-27
} {
 
    # lets create the CR type tables to support the course catalog
    
    content::type::new -content_type "dotlrn_catalog" \
	-pretty_name "\#dotlrn-catalog.package_pretty_name\#" \
	-pretty_plural "\#dotlrn-catalog.package_pretty_name\#" \
 	-table_name "dotlrn_catalog" \
	-id_column "course_id"

    # now set up the attributes that by default we need for the course
    content::type::attribute::new \
	-content_type "dotlrn_catalog" \
	-attribute_name "course_key" \
	-datatype "string" \
	-pretty_name "\#dotlrn-catalog.course_key_pretty_name\#" \
	-pretty_plural "\#dotlrn-catalog.course_key_pretty_name\#" \
	-sort_order 1 \
	-column_spec "varchar(50)"

    content::type::attribute::new \
	-content_type "dotlrn_catalog" \
	-attribute_name "course_name" \
	-datatype "string" \
	-pretty_name "\#dotlrn-catalog.course_name_pretty_name\#" \
	-sort_order 2 \
	-column_spec "varchar(200)"

    content::type::attribute::new \
	-content_type "dotlrn_catalog" \
	-attribute_name "course_info" \
	-datatype "text" \
	-pretty_name "\#dotlrn-catalog.course_info_pretty_name\#" \
	-sort_order 3 \
	-column_spec "text"

    content::type::attribute::new \
	-content_type "dotlrn_catalog" \
	-attribute_name "assessment_id" \
	-datatype "integer" \
	-pretty_name "\#dotlrn-catalog.asm_id_pretty_name\#" \
	-sort_order 4 \
	-column_spec "integer"

    content::type::attribute::new \
	-content_type "dotlrn_catalog" \
	-attribute_name "start_date" \
	-datatype "date" \
	-pretty_name "\#dotlrn-catalog.start_date_pretty_name\#" \
	-sort_order 5 \
	-column_spec "date"

    content::type::attribute::new \
	-content_type "dotlrn_catalog" \
	-attribute_name "end_date" \
	-datatype "date" \
	-pretty_name "\#dotlrn-catalog.end_date_pretty_name\#" \
	-sort_order 6 \
	-column_spec "date"

    content::type::attribute::new \
	-content_type "dotlrn_catalog" \
	-attribute_name "active_p" \
	-datatype "boolean" \
	-pretty_name "\#dotlrn-catalog.active_p\#" \
	-sort_order 7 \
	-column_spec "boolean"

    # To store the courses in the content repository
    set folder_id [content::folder::new -name "DotLRN Catalog" -label "DotLRN Catalog"]
    content::folder::register_content_type -folder_id $folder_id -content_type "dotlrn_catalog" 
    
    # To associate one course to dotlrn class
    rel_types::new -role_one d_catalog_role -role_two dotlrn_class_role dotlrn_catalog_class_rel \
	"DotLRN Catalog Class" "DotLRN Catalog Class" dotlrn_catalog 0 1 dotlrn_class_instance 0 1
    # To associate one course to dotrln community
    rel_types::new -role_one d_catalog_role -role_two dotlrn_com_role dotlrn_catalog_dotcom_rel \
	"DotLRN Catalog Community" "DotLRN Catalog Community" dotlrn_catalog 0 1 dotlrn_club 0 1
}


ad_proc -private dotlrn-catalog::package_mount {
    -package_id
    -node_id
} {
    create the category tree for dotlrn catalog
    
    @author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation-date 11-02-2005
} {
    # To categorize courses
    set tree_id [category_tree::add -name "dotlrn-course-catalog"]
    category_tree::map -tree_id $tree_id -object_id $package_id
}

ad_proc -private dotlrn-catalog::package_uninstall {
} {
    drops the CR type datamodel for the course catalog
    
    @author Miguel Marin (miguelmarin@viaro.net) Viaro Networks (www.viaro.net)
    @creation-date 2005-01-27
} {
    content::type::attribute::delete -content_type "dotlrn_catalog" -attribute_name "course_key" 
    content::type::attribute::delete -content_type "dotlrn_catalog" -attribute_name "course_name" 
    content::type::attribute::delete -content_type "dotlrn_catalog" -attribute_name "course_info" 
    content::type::attribute::delete -content_type "dotlrn_catalog" -attribute_name "assessment_id" 
    set folder_id [dotlrn_catalog::get_folder_id]
    content::folder::unregister_content_type -folder_id $folder_id -content_type "dotlrn_catalog"
    content::folder::delete -folder_id $folder_id -cascade_p "t"
    content::type::delete -content_type "dotlrn_catalog" 
}

ad_proc -private dotlrn-catalog::package_upgrade {
    {-from_version_name:required}
    {-to_version_name:required}
    
} {
    Upgrade procs
    
    @author Anny Flores (annyflores@viaro.net) Viaro Networks (www.viaro.net)
    @creation-date 2005-05-11
} {
    apm_upgrade_logic \
        -from_version_name $from_version_name \
        -to_version_name $to_version_name \
        -spec {
            0.1a4 0.1a5 {
		content::type::attribute::new \
		    -content_type "dotlrn_catalog" \
		    -attribute_name "start_date" \
		    -datatype "date" \
		    -pretty_name "Start Date" \
		    -sort_order 5 \
		    -column_spec "date"
		
		
		content::type::attribute::new \
		    -content_type "dotlrn_catalog" \
		    -attribute_name "end_date" \
		    -datatype "date" \
		    -pretty_name "End Date" \
		    -sort_order 6 \
		    -column_spec "date"

	    }
            0.1a5 0.1a6 {
	
		content::type::attribute::new \
			-content_type "dotlrn_catalog" \
			-attribute_name "active_p" \
			-datatype "boolean" \
			-pretty_name "\#dotlrn-catalog.active_p\#" \
			-sort_order 7 \
			-column_spec "boolean"

	    }
	}
}