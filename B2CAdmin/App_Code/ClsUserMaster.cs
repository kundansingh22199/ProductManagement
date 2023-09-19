using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace B2CAdmin.App_Code
{
    public class ClsUserMaster : ClsSqlConnection
    {
        public DataTable UserLogin(string MobileNo, string Password)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_UserLogin", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MobileNo", MobileNo);
                cmd.Parameters.AddWithValue("@Password", Password);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    return dt;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception)
            {
                return null;
            }

        }
        public DataTable GetStateData()
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_StateMaster", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public DataTable GetCityData(int StateId)
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_CityMaster", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", StateId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }
        public int InsertUpdateUser(string UserId, string UserName, String MobileNo, string Emailid, string CompanyName,
            string Password, int UserType, string Address, string AadharNo, string PanNo, string GstinNo, string UserImage,
            string Aadharimage,string AddharImage2, string PancardImage, string StoreName, string BranchDetails, DateTime Dob,int State,int City,int PinCode,string Gender, int CreateBy, string action)
        {
            try
            {
                int result = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertUpdateUser", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", UserId);
                cmd.Parameters.AddWithValue("@UserName", UserName);
                cmd.Parameters.AddWithValue("@MobileNo", MobileNo);
                cmd.Parameters.AddWithValue("@Emailid", Emailid);
                cmd.Parameters.AddWithValue("@CompanyName", CompanyName);
                cmd.Parameters.AddWithValue("@Password", Password);
                cmd.Parameters.AddWithValue("@UserType", UserType);
                cmd.Parameters.AddWithValue("@Address", Address);
                cmd.Parameters.AddWithValue("@AadharNo", AadharNo);
                cmd.Parameters.AddWithValue("@PanNo", PanNo);
                cmd.Parameters.AddWithValue("@GstinNo", GstinNo);
                cmd.Parameters.AddWithValue("@UserImage", UserImage);
                cmd.Parameters.AddWithValue("@Aadharimage", Aadharimage);
                cmd.Parameters.AddWithValue("@AddharImage2", AddharImage2);
                cmd.Parameters.AddWithValue("@PancardImage", PancardImage);
                cmd.Parameters.AddWithValue("@StoreName", StoreName);
                cmd.Parameters.AddWithValue("@BranchDetails", BranchDetails);
                cmd.Parameters.AddWithValue("@Dob", Dob);
                cmd.Parameters.AddWithValue("@State", State);
                cmd.Parameters.AddWithValue("@City", City);
                cmd.Parameters.AddWithValue("@PinCode", PinCode);
                cmd.Parameters.AddWithValue("@gender", Gender);
                cmd.Parameters.AddWithValue("@CreateBy", CreateBy);
                cmd.Parameters.AddWithValue("@UpdateBy", "");
                cmd.Parameters.AddWithValue("@Action", action);
                con.Open();
                result = cmd.ExecuteNonQuery();
                con.Close();
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }

        }
        public DataTable GetUserType(int Id)
        {
            SqlConnection con = new SqlConnection(SqlCon);
            SqlCommand cmd = new SqlCommand("SP_GetUserTypeData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", Id);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }

        public DataTable UserDetails()
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_GetAllUser", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public int DeleteUserData(int Id)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_DeleteUserById", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", Id);
                con.Open();
                int result = cmd.ExecuteNonQuery();
                return result;
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public DataTable UserDetailsById(int Id)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_GetUserDetailsById", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", Id);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public DataTable UserDetailsByUserId(string UserId)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_GetUserDetailsByUserId", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", UserId);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public DataTable UserDetailsByMobileNo(string MobileMo)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_GetUserDetailsByMobile", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MobileNo", MobileMo);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public DataTable UserDetailsByEmail(string Email)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_GetUserDetailsByEmail", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Emailid", Email);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public int ForgetUserPassword(string UserId, string Password)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_ChangePassword", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", UserId);
                cmd.Parameters.AddWithValue("@Password", Password);
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
        public DataTable SearchUserList(string searchText)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_SearchUserData", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SearchData", searchText);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}