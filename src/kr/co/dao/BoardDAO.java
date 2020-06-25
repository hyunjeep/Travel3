package kr.co.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.sun.xml.internal.bind.v2.util.FatalAdapter;

import kr.co.dto.BoardDTO;
import kr.co.dto.FileDTO;
import kr.co.dto.LocationDTO;
import kr.co.dto.PageTO;

public class BoardDAO {
	private DataSource dataFactory;

	public BoardDAO() {
		try {
			Context ctx = new InitialContext();
			dataFactory = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle11g");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private void closeAll(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void write(BoardDTO dto, FileDTO fto) {
		Connection conn = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		
		String sql1 = "insert into tbl_board (num, writer, title, locationCode, content, repRoot, repStep, repIndent) values (?, ?, ?, ?, ?, ?, ?, ?)";
		String sql2 = "insert into tbl_file (fileNum, fileName, orgFileName, fileUrl) values (?, ?, ?, ?)";
		
		try {
			conn = dataFactory.getConnection();
			pstmt1 = conn.prepareStatement(sql1);

			int num = createNum(conn);

			pstmt1.setInt(1, num);
			pstmt1.setString(2, dto.getWriter());
			pstmt1.setString(3, dto.getTitle());
			pstmt1.setInt(4, dto.getLocationCode());
			pstmt1.setString(5, dto.getContent());
			pstmt1.setInt(6, num);
			pstmt1.setInt(7, 0);
			pstmt1.setInt(8, 0);
			
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, fto.getFileName());
			pstmt2.setString(3, fto.getOrgFileName());
			pstmt2.setString(4, fto.getFileUrl());
			
			pstmt1.executeUpdate();
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt1 != null) {
					pstmt1.close();
				}
				closeAll(null, pstmt2, conn);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	private int createNum(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select max(num) from tbl_board";
		Integer num = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt(1);
				num += 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(rs, pstmt, null);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return num;
	}

	public List<BoardDTO> list() {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from tbl_board b left join tbl_location l on b.locationCode = l.locationCode order by repRoot desc, repStep asc";

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int num = rs.getInt("num");
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				int locationCode = rs.getInt("locationCode");
				String locationName = rs.getString("locationName");
				String writeday = rs.getString("writeday");
				int readcnt = rs.getInt("readcnt");
				int repRoot = rs.getInt("repRoot");
				int repStep = rs.getInt("repStep");
				int repIndent = rs.getInt("repIndent");

				list.add(new BoardDTO(num, writer, title, locationCode, locationName, null, writeday, null, readcnt, repRoot,
						repStep, repIndent));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(rs, pstmt, conn);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}

	public BoardDTO read(int num) {
		FileDTO fto = null;
		BoardDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from (select rownum rnum, num, writer, writeday, title, locationName,"
				+ " content, readcnt, repRoot, repStep, repIndent, fileNum, orgFileName, fileName, fileUrl from"
				+ " (select * from tbl_board b left join tbl_location l on b.locationCode = l.locationCode"
				+ " left join tbl_file f on b.num = f.fileNum order by repRoot desc, repStep asc)) where num=?";
		
		boolean isOk = false;

		try {
			conn = dataFactory.getConnection();

			conn.setAutoCommit(false);
			increaseReadCnt(conn, num);

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				String locationName = rs.getString("locationName");
				String writeday = rs.getString("writeday");
				String content = rs.getString("content");
				int readcnt = rs.getInt("readcnt");
				int fileNum = rs.getInt("fileNum");
				String fileName = rs.getString("fileName");
				String orgFileName = rs.getString("orgFileName");
				String fileUrl = rs.getString("fileUrl");
				
				fto = new FileDTO(fileNum, fileName, orgFileName, fileUrl);
				dto = new BoardDTO(num, writer, title, 0, locationName, content, writeday, fto, readcnt, 0, 0, 0);

				isOk = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			closeAll(rs, pstmt, conn);
		}
		return dto;
	}

	private void increaseReadCnt(Connection conn, int num) {
		PreparedStatement pstmt = null;
		String sql = "update tbl_board set readcnt = readcnt+1 where num=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, null);
		}
	}

	public BoardDTO modifyUI(int num) {
		FileDTO fto = null;
		BoardDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from tbl_board b left join tbl_location l on b.locationCode = l.locationCode left join tbl_file f"
				+ " on b.num = f.fileNum where num=? order by repRoot desc, repStep asc";

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				int locationCode = rs.getInt("locationCode");
				String locationName = rs.getString("locationName");
				String content = rs.getString("content");
				int repRoot = rs.getInt("repRoot");
				int repStep = rs.getInt("repStep");
				int repIndent = rs.getInt("repIndent");
				int fileNum = rs.getInt("fileNum");
				String fileName = rs.getString("fileName");
				String orgFileName = rs.getString("orgFileName");
				String fileUrl = rs.getString("fileUrl");
				
				fto = new FileDTO(fileNum, fileName, orgFileName, fileUrl);
				dto = new BoardDTO(num, writer, title, locationCode, locationName, content, null, fto, 0, repRoot, repStep, repIndent);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(rs, pstmt, conn);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return dto;
	}

	public void modify(BoardDTO dto) {
		FileDTO fto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update (select title, locationCode, content, fileName, orgFileName, fileUrl "
				+ "from tbl_board b left join tbl_file f on b.num = f.fileNum) "
				+ "set title=?, locationCode=?, fileNum=?, fileName=?, orgFileName=?, fileUrl=?"
				+ " where num=?";

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getTitle());
			pstmt.setInt(2, dto.getLocationCode());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, fto.getFileNum());
			pstmt.setString(5, fto.getFileName());
			pstmt.setString(6, fto.getOrgFileName());
			pstmt.setString(7, fto.getFileUrl());
			pstmt.setInt(8, dto.getNum());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(null, pstmt, conn);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public void delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from tbl_board where num=?";

		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(null, pstmt, conn);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public void reply(int orgNum, BoardDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into tbl_board (num, writer, title, locationCode, content, repRoot, repStep, repIndent) values (?, ?, ?, ?, ?, ?, ?, ?)";

		boolean isOk = false;

		try {
			conn = dataFactory.getConnection();
			conn.setAutoCommit(false);

			int num = createNum(conn);
			BoardDTO orgDTO = modifyUI(orgNum);
			stepPlus1(conn, orgDTO);

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getTitle());
			pstmt.setInt(4, dto.getLocationCode());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6, orgDTO.getRepRoot());
			pstmt.setInt(7, orgDTO.getRepStep() + 1);
			pstmt.setInt(8, orgDTO.getRepIndent() + 1);

			pstmt.executeUpdate();

			isOk = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (isOk) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		closeAll(null, pstmt, conn);
	}

	private void stepPlus1(Connection conn, BoardDTO orgDTO) {
		PreparedStatement pstmt = null;
		String sql = "update tbl_board set repStep = repStep+1 where repRoot=? and repStep>?";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, orgDTO.getRepRoot());
			pstmt.setInt(2, orgDTO.getRepStep());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(null, pstmt, null);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	public PageTO page(int curPage, int location) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from (select rownum rnum, num, writer, writeday, title, locationName, content, readcnt, repRoot, repStep, repIndent, fileNum, fileName, orgFileName, fileUrl "
				+ "from (select * from tbl_board b left join tbl_location l on b.locationCode = l.locationCode left join tbl_file f on b.num = f.fileNum where b.locationCode like decode(?, 0, '%', ?)" + 
				" order by repRoot desc, repStep asc)) where rnum >=? and rnum <=?";

		FileDTO fto = null;
		PageTO to = new PageTO(curPage);
		List<BoardDTO> list = new ArrayList<BoardDTO>();

		try {
			conn = dataFactory.getConnection();

			int amount = getAmount(conn, location);
			to.setAmount(amount);
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, location);
			pstmt.setInt(2, location);
			pstmt.setInt(3, to.getStartNum());
			pstmt.setInt(4, to.getEndNum());

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				String locationName = rs.getString("locationName");
				String writeday = rs.getString("writeday");
				int readcnt = rs.getInt("readcnt");
				int repRoot = rs.getInt("repRoot");
				int repStep = rs.getInt("repStep");
				int repIndent = rs.getInt("repIndent");
				int fileNum = rs.getInt("num");
				String fileName = rs.getString("fileName");
				String orgFileName = rs.getString("orgFileName");
				String fileUrl = rs.getString("fileUrl");
				
				fto = new FileDTO(fileNum, fileName, orgFileName, fileUrl);
				BoardDTO dto = new BoardDTO(num, writer, title, 0, locationName, null, writeday, fto, readcnt, repRoot, repStep, repIndent);
				list.add(dto);
			}
			to.setList(list);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(rs, pstmt, conn);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return to;
	}

	private int getAmount(Connection conn, int locationCode) {
		int amount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(num) from tbl_board where locationCode like decode (?, 0, '%', ?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, locationCode);
			pstmt.setInt(2, locationCode);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				amount = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(rs, pstmt, null);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return amount;
	}

	public List<LocationDTO> location() {
		List<LocationDTO> list = new ArrayList<LocationDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from tbl_location order by locationCode asc";
		
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int locationCode = rs.getInt("locationCode");
				String locationName = rs.getString("locationName");
				
				list.add(new LocationDTO(locationCode, locationName));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt, conn);
		}
		return list;
	}

	public int totalNum() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select max(num) from tbl_board";
		Integer num = null;
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(rs, pstmt, conn);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return num;
	}

	public String fileUrl(int num) {
		String fileUrl = null;
		String fileName = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String sql = "select fileName, fileUrl from tbl_file where fileNum=?";
		
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				fileName = rs.getString("fileName");
				fileUrl = rs.getString("fileUrl");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(rs, pstmt, conn);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return fileName;
	}

	public List<FileDTO> fileNumList() {
		List<FileDTO> fileNumList = new ArrayList<FileDTO>();
		int fileNum = 0;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String sql = "select fileNum from tbl_board b left join tbl_file f on b.num = f.fileNum";
		
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				fileNum = rs.getInt("fileNum");
				fileNumList.add(new FileDTO(fileNum));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				closeAll(rs, pstmt, conn);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return fileNumList;
	}
}