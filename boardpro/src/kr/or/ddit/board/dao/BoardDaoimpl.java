package kr.or.ddit.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReplyVO;
import kr.or.ddit.mybatis.config.MybatisUtil;

public class BoardDaoimpl implements IBoardDao{
	//싱글톤
	private static IBoardDao dao;
	
	private BoardDaoimpl() {}
	
	public static IBoardDao getDao() {
		if(dao==null) dao = new BoardDaoimpl();
		
		return dao;
	}

	@Override
	public List<BoardVO> selectBoardList(Map<String, Object> map) {
		//1.변수 선언
		List<BoardVO> list = null;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			list= sql.selectList("board.selectBoardList",map);
									//namespace.select이름인데 메소드이름이랑 같게 만들었어야 한다.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		//3.리턴
		return list;
	}

	@Override
	public int countBoard(Map<String, Object> map) {
		//1.변수 선언
		int cnt=0;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			cnt= sql.selectOne("board.countBoard",map);
									//namespace.select이름인데 메소드이름이랑 같게 만들었어야 한다.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		//3.리턴
		return cnt;
	}

	@Override
	public int insertReply(ReplyVO vo) {
		//1.변수 선언
		int cnt=0;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			cnt= sql.insert("reply.insertReply",vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		//3.리턴
		return cnt;
	}

	@Override
	public List<ReplyVO> selectByReply(int bonum) {
		//1.변수 선언
		List<ReplyVO> list = null;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			list= sql.selectList("reply.selectByReply",bonum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		
		//3.리턴
		return list;
	}

	@Override
	public int insertBoard(BoardVO vo) {
		//1.변수 선언
		int cnt=0;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			cnt= sql.insert("board.insertBoard",vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		//3.리턴
		return cnt;
	}

	@Override
	public int updateHit(int num) {
		//1.변수 선언
		int cnt=0;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			cnt= sql.update("board.updateHit",num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		//3.리턴
		return cnt;
	}

	@Override
	public int deleteBoard(int num) {
		//1.변수 선언
		int cnt=0;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			cnt= sql.delete("board.deleteBoard",num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		//3.리턴
		return cnt;
	}

	@Override
	public int updateBoard(BoardVO vo) {
		//1.변수 선언
		int cnt=0;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			cnt= sql.update("board.updateBoard",vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		//3.리턴
		return cnt;
	}

	@Override
	public int updateReply(ReplyVO vo) {
		//1.변수 선언
		int cnt=0;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			cnt= sql.update("reply.updateReply",vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		//3.리턴
		return cnt;
	}

	@Override
	public int deleteReply(int num) {
		//1.변수 선언
		int cnt=0;
		SqlSession sql = null;
		
		//2.실행
		try {
			sql=MybatisUtil.getSqlSession();
			cnt= sql.update("reply.deleteReply",num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.commit();
			sql.close();
		}
		//3.리턴
		return cnt;
	}
}
