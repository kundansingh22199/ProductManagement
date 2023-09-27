using B2CAdmin.App_Code;
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
    public partial class SellarStock : System.Web.UI.Page
    {
        ClsStockMaster clsStock = new ClsStockMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetSallerStock(0);
            }
        }
        public void GetSallerStock(int pagenumber)
        {
            try
            {
                string userId = Session["UserId"].ToString();
                DataTable dt = clsStock.GetSallerStockList(userId);
                if (dt.Rows.Count > 0)
                {
                    PagedDataSource pgitems = new PagedDataSource();
                    if (txtSearch.Text.Trim() == "")
                    {
                        pgitems.DataSource = dt.DefaultView;
                        pgitems.AllowPaging = true;
                    }
                    else
                    {
                        //DataTable dt1 = clsProduct.SearchProductBySearchText(txtSearch.Text.Trim());
                        //pgitems.DataSource = dt1.DefaultView;
                        //pgitems.AllowPaging = true;
                    }

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
            catch(Exception)
            {

            }
        }

        protected void rptPaging_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int pagenumber = Convert.ToInt32(e.CommandArgument) - 1;
            GetSallerStock(pagenumber);
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName== "Add")
            {
                string StockId = e.CommandArgument.ToString();
                Response.Redirect("ProductList.aspx?StockId=" + StockId);
            }
        }
    }
}