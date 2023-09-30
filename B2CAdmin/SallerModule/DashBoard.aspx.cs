using B2CAdmin.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B2CAdmin.SallerModule
{
    public partial class DashBoard : System.Web.UI.Page
    {
        ClsProfileMaster clsProfile = new ClsProfileMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetDashboardDetails();
            }
        }
        public void GetDashboardDetails()
        {
            string SallerId = Session["UserId"].ToString();
            int TotalSales = clsProfile.GetTotalSalesBySaller(SallerId);
            int TotalCustomer = clsProfile.GetTotalCustomerBySellar(SallerId);
            int TotalItems = clsProfile.GetTotalItemsBySaller(SallerId);
            lblTotalItems.InnerText = TotalItems.ToString();
            lblTotalSales.InnerText = TotalSales.ToString();
            lblTotalCustomer.InnerText = TotalCustomer.ToString();
        }
    }
}