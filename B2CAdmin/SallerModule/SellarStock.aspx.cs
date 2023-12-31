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
            if(e.CommandName== "SetPrice")
            {
                string StockId = e.CommandArgument.ToString();
                ViewState["StockId"]=StockId;
                Label lblPrice = e.Item.FindControl("lblPrice") as Label;
                string price = lblPrice.Text.Replace(",", "");
                txtPurchase.Text = price;
                Label lblMrpPrice = e.Item.FindControl("lblMrpPrice") as Label;
                string MrpPrice = lblMrpPrice.Text.Replace(",", "");
                txtMrpPrice.Text = MrpPrice;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#SellPriceModel').modal();", true);
            }
        }

        protected void btnSetPrice_Click(object sender, EventArgs e)
        {
            try
            {
                decimal MrpPrice = Convert.ToDecimal(txtMrpPrice.Text);
                decimal PurchasePrice = Convert.ToDecimal(txtPurchase.Text);
                int result = 0;
                int Id = Convert.ToInt32(ViewState["StockId"]);
                decimal SellingPrice = Convert.ToDecimal(txtSalesPrice.Text.Trim());
                decimal Product_Price = Convert.ToDecimal(txtProductPrice.Text.Trim());
                decimal DiscountValue = Convert.ToDecimal(txtDiscount.Text.Trim());
                int DiscountType = Convert.ToInt32(ddlDiscountType.SelectedValue);
                if (MrpPrice > SellingPrice && PurchasePrice < SellingPrice)
                {
                    result = clsStock.SetSellingPrice(Id, SellingPrice, Product_Price, DiscountValue, DiscountType);
                    if (result > 0)
                    {
                        GetSallerStock(0);
                        msgsuccess.InnerText = "Price Set Successfull";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ConformationModel').modal();", true);
                    }
                    else
                    {
                        msg.InnerText = "Somthing Wrong";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                    }
                }
                else
                {
                    msg.InnerText = "Selling Price is Lass than Mrp Price And Gratter Than Purchase Price";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                }
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}