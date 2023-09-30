using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace B2CAdmin.App_Code
{
    public class ClsProfileMaster : ClsSqlConnection
    {
        public int UpdateProfile(string UserName, string MobileNo, string Emailid, string Address, string UserImage, string Dob, string Gender, int State, int City, string PinCode, int UpdateBy, int Id)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_ProfileUpdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserName", UserName);
                cmd.Parameters.AddWithValue("@MobileNo", MobileNo);
                cmd.Parameters.AddWithValue("@Emailid", Emailid);
                cmd.Parameters.AddWithValue("@Address", Address);
                cmd.Parameters.AddWithValue("@UserImage", UserImage);
                cmd.Parameters.AddWithValue("@Dob", Dob);
                cmd.Parameters.AddWithValue("@Gender", Gender);
                cmd.Parameters.AddWithValue("@State", State);
                cmd.Parameters.AddWithValue("@City", City);
                cmd.Parameters.AddWithValue("@PinCode", PinCode);
                cmd.Parameters.AddWithValue("@UpdateBy", UpdateBy);
                cmd.Parameters.AddWithValue("@Id", Id);
                con.Open();
                int result = cmd.ExecuteNonQuery();
                con.Close();
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
            
        }
        public int GetTotalSales()
        {
            try
            {
                int Quantity = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("select  sum (Quantity)as TotalSales from  TblOrderMaster where Status='Approved'", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Quantity = Convert.ToInt32(dt.Rows[0]["TotalSales"]);
                return Quantity;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public int GetTotalSalesBySaller(string SellerId)
        {
            try
            {
                int Quantity = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("select  sum (S_Quantity)as TotalSales from  TblSalesMaster where S_Sellar_Id=" + SellerId, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Quantity = Convert.ToInt32(dt.Rows[0]["TotalSales"]);
                return Quantity;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public int GetTotalItemsBySaller(string SallerId)
        {
            try
            {
                int Quantity = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("select  sum (Quantity)as TotalItems from  TblSellarStock where SallerId =" + SallerId, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Quantity = Convert.ToInt32(dt.Rows[0]["TotalItems"]);
                return Quantity;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public int GetTotalPendingSales()
        {
            try
            {
                int Quantity = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("select  sum (Quantity)as TotalPendingSales from  TblOrderMaster where Status='Pending'", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Quantity = Convert.ToInt32(dt.Rows[0]["TotalPendingSales"]);
                return Quantity;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        public int GetTotalCancleSales()
        {
            try
            {
                int Quantity = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("select  sum (Quantity)as TotalCancleSales from  TblOrderMaster where Status='Cancle'", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Quantity = Convert.ToInt32(dt.Rows[0]["TotalCancleSales"]);
                return Quantity;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public int GetTotalSaller()
        {
            try
            {
                int Total = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("select count(*) as TotalSaller from TblUSerMaster where UserType=2", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Total = Convert.ToInt32(dt.Rows[0]["TotalSaller"]);
                return Total;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public int GetTotalCustomer()
        {
            try
            {
                int Total = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("select count(*) as TotalCustomer from TblCustomerMaster", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Total = Convert.ToInt32(dt.Rows[0]["TotalCustomer"]);
                return Total;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public int GetTotalCustomerBySellar(string SellarId)
        {
            try
            {
                int Total = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("select count(*) as TotalCustomer from TblCustomerMaster where CreateBy="+ SellarId, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Total = Convert.ToInt32(dt.Rows[0]["TotalCustomer"]);
                return Total;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public int GetTotalItems()
        {
            try
            {
                int Total = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("select Sum(ProductQuantity) as TotalItems from TblStockMaster", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Total = Convert.ToInt32(dt.Rows[0]["TotalItems"]);
                return Total;
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}