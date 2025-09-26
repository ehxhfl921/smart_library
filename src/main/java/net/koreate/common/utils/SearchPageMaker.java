package net.koreate.common.utils;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class SearchPageMaker extends PageMaker{
	
	public SearchPageMaker(Criteria cri,  int totalCount, int displayPageNum){
		super(cri, totalCount, displayPageNum);
	}

	@Override
	public String makeQuery(int page) {
		SearchCriteria sCri = (SearchCriteria)cri;
		UriComponents uriComponentsents = 
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchType", sCri.getSearchType())
				.queryParam("keyword",sCri.getKeyword())
				.build();
		String query = uriComponentsents.toUriString();
		return query;
	}
	
	public String makeQueryBno(int bno) {
		SearchCriteria sCri = (SearchCriteria)cri;
		UriComponents uriComponentsents = 
				UriComponentsBuilder.newInstance()
				.queryParam("page", cri.getPage())
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchType", sCri.getSearchType())
				.queryParam("keyword",sCri.getKeyword())
				.queryParam("bno", bno)
				.build();
		String query = uriComponentsents.toUriString();
		return query;
	}
	
	

}






