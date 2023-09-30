using B2CAdmin.App_Code;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B2CAdmin.AdminModule
{
    public partial class ProductAssign : System.Web.UI.Page
    {
        ClsOrderMaster clsOrder = new ClsOrderMaster();
        ClsStockMaster clsStock = new ClsStockMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrderLists(0);
            }
        }
        public void BindOrderLists(int pagenumber)
        {
            try
            {
                DataTable dt = clsOrder.GetOrderList();
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
            BindOrderLists(pagenumber);
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Details")
            {

            }
            else if (e.CommandName == "Approved")
            {
                Label lblStatus = e.Item.FindControl("lblStatus") as Label;
                ViewState["Status"] = lblStatus.Text;
                Label lblStockId = e.Item.FindControl("lblStockId") as Label;
                ViewState["StockId"] = lblStockId.Text;
                Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
                ViewState["OrderQuantity"] = lblQuantity.Text;
                Label lblOrderBy = e.Item.FindControl("lblOrderBy") as Label;
                ViewState["OrderBy"] = lblOrderBy.Text;
                ViewState["Id"] = e.CommandArgument;
                msg.InnerText = "Are You Sure? To Confirm This Order";
                btnSucess.Visible = true;
                btnCancle.Visible = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ActionModel').modal();", true);
            }
            else if (e.CommandName == "Reject")
            {
                Label lblStatus = e.Item.FindControl("lblStatus") as Label;
                ViewState["Status"] = lblStatus.Text;
                ViewState["Id"] = e.CommandArgument;
                msg.InnerText = "Are You Sure? To Cancle This Order";
                btnSucess.Visible = false;
                btnCancle.Visible = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ActionModel').modal();", true);
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblStatus = e.Item.FindControl("lblStatus") as Label;
                if (lblStatus.Text.ToLower() == "pending")
                {
                    lblStatus.BackColor = Color.FromArgb(230, 134, 19);
                }
                else if (lblStatus.Text.ToLower() == "approved")
                {
                    lblStatus.BackColor = Color.Green;
                }
                else
                {
                    lblStatus.BackColor = Color.Red;
                }
            }
        }

        protected void btnCancle_Click(object sender, EventArgs e)
        {
            int Id = Convert.ToInt32(ViewState["Id"]);
            string Status = ViewState["Status"].ToString();
            string userId = Session["UserId"].ToString();
            if (Status.ToLower() == "approved")
            {
                errormsg.InnerText = "Approved Status Can Not be Cancalled";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
            }
            else if (Status.ToLower() == "cancle")
            {
                errormsg.InnerText = "Order Already Cancle Cancalled";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
            }
            else
            {
                int result = clsOrder.UpdateOrderStatus(Id, "Cancle", userId);
                if (result > 0)
                {
                    BindOrderLists(0);
                    msgsuccess.InnerText = "Successfull Cancled";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ConformationModel').modal();", true);
                }
                else
                {
                    errormsg.InnerText = "Somthing Wrong";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                }
            }
        }

        protected void btnSucess_Click(object sender, EventArgs e)
        {
            string Status = ViewState["Status"].ToString();
            if (Status.ToLower() == "approved")
            {
                errormsg.InnerText = "Already Approved";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
            }
            else if (Status.ToLower() == "pending")
            {
                int Id = Convert.ToInt32(ViewState["Id"]);
                string userId = Session["UserId"].ToString();
                int userIdInt = Convert.ToInt32(userId);
                int StockId = Convert.ToInt32(ViewState["StockId"]);
                int OrderBy = Convert.ToInt32(ViewState["OrderBy"]);
                DataTable dt = clsStock.GetStockDataById(StockId);
                if (dt.Rows.Count > 0)
                {
                    int quantity = Convert.ToInt32(dt.Rows[0]["ProductQuantity"]);
                    decimal Price = Convert.ToDecimal(dt.Rows[0]["SalesPrice"]);
                    int orderQuantity = Convert.ToInt32(ViewState["OrderQuantity"]);
                    if (quantity >= orderQuantity)
                    {
                        int AvilableQuantity = quantity - orderQuantity;
                        int result = clsStock.UpdateStockById(AvilableQuantity, userIdInt, StockId);
                        if (result > 0)
                        {
                            int result1 = clsOrder.UpdateOrderStatus(Id, "Approved", userId);
                            int result2 = clsOrder.InsertSallerStock(StockId, OrderBy, orderQuantity, Price);
                            BindOrderLists(0);
                            msgsuccess.InnerText = "Successfull Approved";
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
                        errormsg.InnerText = "Your Stock Is Low";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                    }
                }
            }
            else
            {
                errormsg.InnerText = "This Order Can Not be Approved";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
            }
        }
    }
}