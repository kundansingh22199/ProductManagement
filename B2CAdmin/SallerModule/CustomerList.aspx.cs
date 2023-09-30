﻿using B2CAdmin.App_Code;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B2CAdmin.SallerModule
{
    public partial class CustomerList : System.Web.UI.Page
    {
        ClsSalesMaster clsSales = new ClsSalesMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCustomerLists(0);
            }
        }
        public void BindCustomerLists(int pagenumber)
        {
            try
            {
                string CreateBy = Session["UserId"].ToString();
                DataTable dt = clsSales.GetCustomerListBySallerId(CreateBy);
                if (dt.Rows.Count > 0 && dt != null)
                {
                    PagedDataSource pgitems = new PagedDataSource();
                    pgitems.DataSource = dt.DefaultView;
                    pgitems.AllowPaging = true;
                    //control page size from here 
                    pgitems.PageSize = 5;
                    pgitems.CurrentPageIndex = pagenumber;
                    if (pgitems.PageCount > 1)
                    {
                        rptPaging.Visible = true;
                        ArrayList pages = new ArrayList();
                        for (int i = 0; i <= pgitems.PageCount - 1; i++)
                        {
                            pages.Add((i + 1).ToString());
                        }
                        rptPaging.DataSource = pages;
                        rptPaging.DataBind();
                    }
                    else
                    {
                        rptPaging.Visible = false;
                    }
                    Repeater1.DataSource = pgitems;
                    Repeater1.DataBind();
                }
                else
                {
                    Repeater1.DataSource = null;
                    Repeater1.DataBind();
                }
            }
            catch
            {

            }
            finally
            {

            }
        }
        protected void rptPaging_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int pagenumber = Convert.ToInt32(e.CommandArgument) - 1;
            BindCustomerLists(pagenumber);
        }
    }
}