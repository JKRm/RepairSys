var indexdata1 = 
[
    { text: '基本信息',isexpand:false, children: [ 
		{url:"staffinfo/StaffAction.action",text:"我的信息"},
		{url:"staffInfo/ModifyPassword.jsp",text:"修改密码"}
	]
    },
	{ isexpand: "false", text: "报修管理", children: [
        { isexpand: "false", text: "报修项目查询", children: [
		    { url: "repair/RepairAction.action", text: "报修编号查询" },
            { url: "repair/RepairStateAction.action", text: "报修状态查询" },
		    { url: "repair/RepairTimeAction.action", text: "按日期查询" },
		    { url: "repair/RepairLocationAction.action", text: "按地点查询" }
	    ] 
        }, 
		{url:"report/GetInfoAction.action",text:"添加报修"} 
    ]
    }
];

var indexdata2 = 
	[
	    { text: '基本信息',isexpand:false, children: [ 
		{url:"staffinfo/StaffAction.action",text:"我的信息"},
		{url:"staffInfo/ModifyPassword.jsp",text:"修改密码"}
		]
	    },
		{ isexpand: "false", text: "报修管理", children: [
        { isexpand: "false", text: "报修项目查询", children: [
		    { url: "repair/RepairAction.action", text: "报修编号查询" },
            { url: "repair/RepairStateAction.action", text: "报修状态查询" },
		    { url: "repair/RepairTimeAction.action", text: "按日期查询" },
		    { url: "repair/RepairLocationAction.action", text: "按地点查询" }
	    ] 
        }, 
			{url:"report/GetInfoAction.action",text:"添加报修"}, 
			{url:"report/ReportApprovalAction.action",text:"报修审批"} 
	    ]
	    },
	    { text: '维修管理',isexpand:false, children: [ 
	        {url:"maintenance/ShowListAction.action",text:"添加/修改维修信息"}
	    ]
	    },	    
	    { text: '费用管理',isexpand:false, children: [ 
	         {url:"ExpenseInfo/ExpenseAddition.jsp",text:"添加缴费"},
	         {url:"expense/searchAction.action",text:"维修价目查询"}
	    ]
	    },	 
	    { text: '汇总打印',isexpand:false, children: [ 
	         {url:"total/TotalRepairAction.action",text:"费用汇总"},
	         {url:"total/TotalSuppliesAction.action",text:"物料信息汇总"}
	    ]
	    }
];


var indexdata3 = 
	[
	 { text: '基本信息',isexpand:false, children: [ 
		    {url:"staffinfo/StaffAction.action",text:"我的信息"},
		    {url:"staffInfo/ModifyPassword.jsp",text:"修改密码"}
	 ]
	 },
	 { isexpand: "false", text: '用戶管理', children: [ 
	        {url:"admin/staff/getStaffs.action",text:"用戶操作"} 
	 ]
	 },
	 { text: '房屋信息管理',isexpand:false, children: [ 
	        {url:"locationinfo/infoAction.action",text:"区域负责人修改"},
	        {url:"locationinfo/infobAction.action",text:"楼群负责人修改"},
	        {url:"locationinfo/infolAction.action",text:"房屋负责人修改"}
	 ]
	 },	    
	 { text: '报修/维修信息管理',isexpand:false, children: [ 
	        {url:"report/ShowListAction.action",text:"报修信息维护"},
	        {url:"maintenance/ShowListAction.action",text:"维修信息维护"}
	 ]
	 },	 
	 { text: '评价管理',isexpand:false, children: [ 
	        {url:"comment/ShowCommentAction.action",text:"评价信息维护"}
	 ]
	 },
	 { text: '通知文件管理',isexpand:false, children: [ 
	        {url:"admin/notice/add.jsp",text:"添加通知"},
	        {url:"admin/notice/getList.action",text:"编辑通知"}
	 ]
	 },
	 { text: '物料管理',isexpand:false, children: [ 
            {url:"supplies/suppliesAction.action",text:"物料操作"},
            {url:"expense/searchAction.action",text:"查询物料"}
     ]
	 }
];

