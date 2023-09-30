using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using B2CAdmin.App_Code;
using System.Drawing;
using System.Web.UI.WebControls;
namespace B2CAdmin.SallerModule
{
    public partial class SalesPage : System.Web.UI.Page
    {
        ClsStockMaster clsStock = new ClsStockMaster();
        ClsSalesMaster clsSales = new ClsSalesMaster();
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
                DataTable dt = clsStock.GetSallerStockListBySalesPrice(userId);
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
            catch (Exception)
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
            if (e.CommandName == "Buy")
            {
                ViewState["StockId"] = e.CommandArgument;
                Label lblPrice = e.Item.FindControl("lblSellingPrice") as Label;
                txtPrice.Text = lblPrice.Text;
                Label lblProductCode = e.Item.FindControl("lblProductCode") as Label;
                ViewState["ProductCode"] = lblProductCode.Text;
                Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
                ViewState["StockQuantity"] = lblQuantity.Text;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ActionModel').modal();", true);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string UserId = Session["UserId"].ToString();
            int count = 0;
            int Quantity = Convert.ToInt32(txtQuantity.Text.Trim());
            decimal Price = Convert.ToDecimal(txtPrice.Text.Trim().Replace(",",""));
            decimal TotalPrice = Price * Quantity;
            string StockId = ViewState["StockId"].ToString();
            string ProductCode = ViewState["ProductCode"].ToString();
            int StockQuantity = Convert.ToInt32(ViewState["StockQuantity"]);
            if (StockQuantity > Quantity)
            {
                count = clsSales.CheckDuplicateCustomer(txtMobileNo.Text.Trim());
                string Status = "1";
                if (count > 0)
                {
                    int result = clsSales.BuyProduct(txtMobileNo.Text.Trim(), ProductCode, StockId, UserId, Quantity, Price, TotalPrice, Status);
                    if (result > 0)
                    {
                        GetSallerStock(0);
                        msgsuccess.InnerText = "Order Successfull";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ConformationModel').modal();", true);
                    }
                    else
                    {
                        errormsg.InnerText = "Somthing Wrong";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                    }
                }
                else
                {
                    int result1 = clsSales.InsertCustomer(txtMobileNo.Text.Trim(), txtName.Text.Trim(), txtMobileNo.Text.Trim(), Status, UserId);
                    int result2 = clsSales.BuyProduct(txtMobileNo.Text.Trim(), ProductCode, StockId, UserId, Quantity, Price, TotalPrice, Status);
                    if (result2 > 0 && result1>0)
                    {
                        GetSallerStock(0);
                        msgsuccess.InnerText = "Order Successfull";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ConformationModel').modal();", true);
                    }
                    else
                    {
                        errormsg.InnerText = "Somthing Wrong";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                    }
                }
            }
            else
            {
                errormsg.InnerText = "Low Stock";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
            }
            
        }
    }
}