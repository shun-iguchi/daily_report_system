<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${report != null}">
                <h2>日報　詳細ページ</h2>

                <table>
                    <tbody>
                        <tr>
                            <th>氏名</th>
                            <td><c:out value="${report.employee.name}" /></td>
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value="${report.report_date}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                        <tr>
                            <th>内容</th>
                            <td>
                                <pre><c:out value="${report.content}" /></pre>
                            </td>
                        </tr>
                        <tr>
                            <th>登録日時</th>
                            <td>
                                <fmt:formatDate value="${report.created_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td>
                                <fmt:formatDate value="${report.updated_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                        <tr>
                            <th>ステータス</th>
                            <td class="report_status">
                            <c:if test="${report.approval == 0}">
                                  承認
                            </c:if>
                            <c:if test="${report.approval == 1}">
                                  非承認
                            </c:if>
                            <c:if test="${report.approval == 2}">
                                  審査中
                            </c:if></td>
                        </tr>
                        <tr>
                            <th>承認</th>
                            <td class="report_approval">
                            <c:if test="${sessionScope.login_employee != null}">
                        <c:if test="${sessionScope.login_employee.admin_flag == 2|| sessionScope.login_employee.admin_flag == 3}">
                            <div style="display: inline-flex">
                                <form method="POST" action="<c:url value='/reports/approval' />">
                                    <input type="hidden" name="report_id" value="${report.id}" />
                                    <input type="hidden" name="approval" value="0" />
                                    <button type="submit" name="submit" value="${0}">承認</button>
                                </form>
                                &nbsp;
                                <form method="POST" action="<c:url value='/reports/approval' />">
                                    <input type="hidden" name="report_id" value="${report.id}" />
                                    <input type="hidden" name="approval" value="1" />
                                    <button type="submit" name="submit" value="${1}">非承認</button>
                                </form>
                            </div>
                        </c:if>
                      </c:if>
                    </td>
                  </tr>
               </tbody>
            </table>

                <c:if test="${sessionScope.login_employee.id == report.employee.id}">
                    <p><a href="<c:url value="/reports/edit?id=${report.id}" />">この日報を編集する</a></p>
                </c:if>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <p><a href="<c:url value="/reports/index" />">一覧に戻る</a></p>
    </c:param>
</c:import>