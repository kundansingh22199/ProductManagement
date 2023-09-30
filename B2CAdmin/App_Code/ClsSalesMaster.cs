using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace B2CAdmin.App_Code
{
    public class ClsSalesMaster: ClsSqlConnection
    {
        public int CheckDuplicateCustomer(string MobileNo)
        {
            try
            {
                int Count = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_GetCustomerByMobile", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@C_MoNo", MobileNo);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    Count = dt.Rows.Count;
                    return Count;
                }
                else
                {
                    return 0;
                }
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        public int InsertCustomer(string CustomerId,string Name, string MobileNo,string status,string CreateBy)
        {
            try
            {
                int Count = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertCustomer", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CustomerId", CustomerId);
                cmd.Parameters.AddWithValue("@C_Name", Name);
                cmd.Parameters.AddWithValue("@C_MoNo", MobileNo);
                cmd.Parameters.AddWithValue("@C_EmailId", "");
                cmd.Parameters.AddWithValue("@C_status", status);
                cmd.Parameters.AddWithValue("@CreateBy", CreateBy);
                con.Open();
                return Count = cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public int BuyProduct(string CustomerId, string ProductCode, string StockId, string SellarId,int Quantity,decimal Price,decimal TotalPrice, string Status)
        {
            try
            {
                int Count = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertSellarMaster", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@S_CustomerId", CustomerId);
                cmd.Parameters.AddWithValue("@S_ProductCode", ProductCode);
                cmd.Parameters.AddWithValue("@S_StockId", StockId);
                cmd.Parameters.AddWithValue("@S_Sellar_Id", SellarId);
                cmd.Parameters.AddWithValue("@S_Quantity", Quantity);
                cmd.Parameters.AddWithValue("@S_Price", Price);
                cmd.Parameters.AddWithValue("@S_TotalPrice", TotalPrice);
                cmd.Parameters.AddWithValue("@S_Status", Status);
                con.Open();
                return Count = cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
    }
}