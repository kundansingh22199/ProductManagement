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
    public partial class ProductList : System.Web.UI.Page
    {
        ClsProductMaster clsProduct = new ClsProductMaster();
        ClsStockMaster clsStock = new ClsStockMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductLists(0);
                BindCatogery();
            }
        }
        public void ProductLists(int pagenumber)
        {
            try
            {
                DataTable dt = clsProduct.ProductListDetailsJoin();
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
                        DataTable dt1 = clsProduct.SearchProductBySearchText(txtSearch.Text.Trim());
                        pgitems.DataSource = dt1.DefaultView;
                        pgitems.AllowPaging = true;
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
            ProductLists(pagenumber);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
        public void BindCatogery()
        {
            DataTable dt = clsProduct.GetCtogeryData();
            ddlCatogery.DataSource = dt;
            ddlCatogery.DataTextField = "CatogeryName";
            ddlCatogery.DataValueField = "Id";
            ddlCatogery.DataBind();

            ListItem selectItem = new ListItem("--Select--", "Selected");
            selectItem.Selected = true;
            ddlCatogery.Items.Insert(0, selectItem);
        }
        public void BindSubCatogery(int catogeryId)
        {
            DataTable dt = clsProduct.GetSubCtogeryData(catogeryId);
            ddlSubCatogery.DataSource = dt;
            ddlSubCatogery.DataTextField = "SubCatogeryName";
            ddlSubCatogery.DataValueField = "Id";
            ddlSubCatogery.DataBind();

            ListItem selectItem = new ListItem("--Select--", "Selected");
            selectItem.Selected = true;
            ddlSubCatogery.Items.Insert(0, selectItem);
        }

        protected void ddlCatogery_SelectedIndexChanged(object sender, EventArgs e)
        {
            int catogeryId = Convert.ToInt32(ddlCatogery.SelectedValue);
            BindSubCatogery(catogeryId);
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Order")
            {
                Label txtId = (Label)e.Item.FindControl("lblId");
                DataTable dt = clsStock.GetStockDataByStockId(Convert.ToInt32(txtId.Text.Trim()));
                if (dt.Rows.Count > 0)
                {
                    txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                    txtSerialNo.Text = dt.Rows[0]["SerialNo"].ToString();
                    txtHsnCode.Text = dt.Rows[0]["HSNCode"].ToString();
                    txtSize.Text = dt.Rows[0]["Size"].ToString();
                    txtMrpPrice.Text = dt.Rows[0]["MrpPrice"].ToString();
                    string discountType = dt.Rows[0]["DiscountType"].ToString();
                    string discount = "";
                    if (discountType == "1")
                    {
                        discount = dt.Rows[0]["Discount"].ToString() + " %";
                    }
                    else
                    {
                        discount = dt.Rows[0]["Discount"].ToString() + " RS";
                    }
                    
                    string tax = dt.Rows[0]["TaxType"].ToString();
                    txtPrice.Text = dt.Rows[0]["SalesPrice"].ToString();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowOrderPopup();", true);
                }
            }
            if (e.CommandName == "Cancle")
            {

            }
        }
    }
}